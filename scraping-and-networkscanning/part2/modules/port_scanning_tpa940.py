#!/usr/bin/python

import sys, json, csv
import nmap


def print_header():
    print("----------------------------------------------------")
    print("Assignment 4 Part 2: Port scanning with nmap\n")
    print("Teresa Pan  (300370940)")
    print("----------------------------------------------------")


def run_nmap(server_dict):
    # server from conf is a list, need to change it to String
    host_list = " ".join(server_dict['servers'])
    port_list = server_dict['ports']
    
    nm = nmap.PortScanner()

    result = nm.scan(hosts=host_list, ports=port_list, arguments='-Pn')
    
    scan_results={} # create an empty dictionary to store results

    for host in nm.all_hosts():
        print(f"Host {nm[host].hostname()} IP {host} Status {nm[host].state()}")

        for proto in nm[host].all_protocols():
            lport = nm[host][proto].keys()
            for port in lport:
                print(f"\tPort {port} is {nm[host][proto][port]['state']}")
        print("")


    for host in result['scan']:
        host_info={}

        host_info['ip'] = host
        host_info['status'] = result['scan'][host]['status']['state']

        ports_info=[]

        for port in result['scan'][host]['tcp']:
            port_status = result['scan'][host]['tcp'][port]['state']
            ports_info.append((port,port_status))

        host_info['ports'] = ports_info
        scan_results[host]=host_info
    
    return scan_results 


def write_csv(scan_results, filename="output_part2_tpa940.csv"):

    with open(filename, mode='w', newline='') as file:
        writer = csv.writer(file)
        
        # write header
        writer.writerow(['Server IP','Port','Status'])
        
        for host, info in scan_results.items():
            ip = info['ip']
            for port, status in info['ports']:
                writer.writerow([ip,port,status])




    

