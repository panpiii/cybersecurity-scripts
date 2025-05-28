#!/usr/bin/python


import modules.port_scanning_tpa940 as pscan
import modules.configuration as config # to access the dictionary in configuration.py

pscan.print_header()

scan_results = pscan.run_nmap(config.conf)

pscan.write_csv(scan_results)


