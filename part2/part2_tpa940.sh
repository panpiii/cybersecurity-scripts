#!/bin/bash

source inc/server-info.inc
source inc/user-info.inc

SERVER_LIST="conf/servers.txt"

readarray -t SERVER < $SERVER_LIST

for server in ${SERVER[@]}
do 
	echo $server
	echo "Server Info:"
	check-info $SERVER 2>/dev/null
	echo "User Info:"
	check-user-info $SERVER 2>/dev/null
	echo "done"
done
