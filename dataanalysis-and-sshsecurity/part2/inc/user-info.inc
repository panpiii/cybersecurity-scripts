function check-user-info() {
	SERVER=$1

	# Number of users
        USER=$(ssh assign2@$SERVER cat /etc/passwd | wc -l)

	# Number of groups
	GROUPS=$(ssh assign2@$SERVER cat /etc/ group | wc -l )

	# Number of users with home directory within /home
	#HOME_USERS=$(ssh assign2@$SERVER "getent passwd | awk -F: '\$6 ~ /^\/home/ { print \$1 }' | wc -l")
        HOME_USERS=$(ssh assign2@$SERVER cat /etc/passwd | cut -d":" -f6 | grep "home" | wc -l)

	echo "Number of users: $USER"
	echo "Number of groups: $GROUPS"
	echo "Users with home directory in /home: $HOME_USERS"

}

