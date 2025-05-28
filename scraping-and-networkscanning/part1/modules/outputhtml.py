#!/usr/bin/python

import json

def create_html_output(exam_schedule, template="course_template.html", output_file="output_tpa940.html"):
    with open(template, 'r') as temp:
        template_content = temp.read()

    table_rows=""

    for exam in exam_schedule:
        rows= f"""
        <tr>
            <td>{exam['Course Name']}</td>
            <td>{exam['Course']}</td>
            <td>{exam['Section']}</td>
            <td>{exam['Date']}</td>
            <td>{exam['Time']}</td>
            <td>{exam['Bldg']}</td>
            <td>{exam['Room']}</td>
        </tr>

        """
        table_rows += rows

    table_headers="""
    <thead>
        <tr>
            <th>Course Name</th>
            <th>Course</th>
            <th>Section</th>
            <th>Date</th>
            <th>Time</th>
            <th>Blg</th>
            <th>Room</th>
        </tr>
    </thead>

    """

    final_html = template_content.replace('<table>', f'<table>{table_headers}{table_rows}</table>')

    with open(output_file, 'w') as output_f:
        output_f.write(final_html)

    print(f"HTML created: {output_file}")
    # print(final_html)

