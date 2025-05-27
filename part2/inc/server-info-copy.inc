function check-info() {
	SERVER=$1

	# Number of running services

	SERVICES=$(ssh assign2@$SERVER "systemctl --type=service --state=running | wc -l")

	# Free memory

	FREE_MEM=$(ssh assign2@$SERVER "free -h | awk '/^Mem:/ { print \$4 }'")
	
	# Last 5 minutes load average
        LOAD_AVG=$(ssh assign2@$SERVER "uptime | awk -F'load average:' '{ print \$2 }' | cut -d, -f2 | xargs")

	echo "Services running: $SERVICES"
	echo "Free memory: ${FREE_MEM}MB"
	echo "Load average (in last 5 minutes): $LOAD_AVG"

}
