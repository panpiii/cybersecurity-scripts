#!/usr/bin/python

import csv, json
import modules.webscrap as ws
import modules.outputhtml as oph
courses = ws.fetch_course_data("course_data.csv")
exam_schedule = ws.fetch_exam_schedule(courses)
ws.create_json_output(exam_schedule)
oph.create_html_output(exam_schedule)
