#!/bin/bash

# source the header function
#

source ./inc/header_tpa940.inc
source ./inc/analyze_tpa940.inc
# call the function

display_header
analyze_csv "./data/cyber.csv"
