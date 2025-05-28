#!/usr/bin/python

# Module for webscrapping douglas website

import bs4,requests, json, csv
from bs4 import BeautifulSoup

def fetch_course_data(csv_file):
    needed_courses = set()
    with open(csv_file,'r') as file:
        reader = csv.reader(file)
        for row in reader:
            course_code, section = row
            needed_courses.add(f"{course_code},{section.strip()}")
    print(needed_courses)
    return needed_courses

def fetch_exam_schedule(needed_course):
    url="https://www.douglascollege.ca/current-students/important-dates-information/exam-schedule"

    page=requests.get(url)

    #handling raising exception
    page.raise_for_status()

    content = bs4.BeautifulSoup(page.text, "html.parser")
    exam_schedule=[]
    tables = content.find_all("table")

    for table in tables:
        rows = table.find_all('tr')
        for row in rows[1:]:
            cols = row.find_all('td')
            if len(cols)>8:

                course_code = cols[0].text.strip()
                section= cols[1].text.strip()
                
                course_last4degit = course_code[-4:]

                if f"{course_last4degit},{section}" in needed_course:
                    # for debugging
                    #print(f"Found matching course!{course_last4degit} {section}")
                    course_name = get_course_name(course_last4degit)
                    #print(course_name)

                    
                    date = cols[3].text.strip()
                    time = " ".join([cols[4].text.strip(), cols[5].text.strip(),cols[6].text.strip()])
                    building = cols[7].text.strip()
                    room = cols[8].text.strip()

                    exam_schedule.append({
                        'Course Name': course_name,
                        'Course':course_last4degit,
                        'Section':section,
                        'Date':date,
                        'Time':time,
                        'Bldg':building,
                        'Room':room
                        })
    print(f"Exam schedule: {exam_schedule}")
    return exam_schedule


def get_course_name(course_code):

    url = f"https://www.douglascollege.ca/course/csis-{course_code}"
    page = requests.get(url)
    page.raise_for_status()

    soup = BeautifulSoup(page.text, "html.parser")

    course_name = soup.find('h1').text.strip().title()

    print(f"Course name for {course_code}:{course_name}")
    return course_name

def create_json_output(exam_schedule, output_filename="output_tpa940.json"):
    
    with open(output_filename, 'w') as json_file:
        json.dump(exam_schedule, json_file, indent=4)
