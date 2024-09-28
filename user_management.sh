#!/bin/bash
add_user() {
	read -p "Enter Username you want to add : " username
	sudo useradd $username
	sudo passwd $username
	echo "User $username has been added succesfully."
}

remove_user() {
	read -p "Enter the user you want to remove : " username
	if id "$username" &>/dev/null; then
		sudo userdel $username
		echo "user $username has been removed succesfully."
	else
		echo "User $username does not exist!"
	fi
}

modify_user() {
	read -p "Enter the username you want to modify" username
	if id "$username" &>/dev/null; then
		echo "What would you like to modify ?"
		echo "Press 1 to change username"
		echo "press 2 to change home directory"
		echo "press 3 to change default shell"
		echo "press 4 to add a group"
		read -p "Choose an option : " option

		case $option in
			1)
				read -p "enter new username" newusername
				sudo usermod -l "$newusername" "$username"
				echo "Username $username has been changed to $newusername succesfully"
				;;

			2)
				read -p "enter the name of directory you want to change" newdirectory
				sudo usermod -d "$newdirectory" -m "$username"
				echo "Home directory for $username changed to $newdirectory ."
				;;
			3)
				read -p "Enter the new default shell (e.g., /bin/bash): " new_shell
				sudo usermod -s "$new_shell" "$username"
				echo "Default shell for $username changed to $new_shell."
				;;
			4)
				read -p "Enter the group to add $username to: " group
				sudo usermod -aG "$group" "$username"
				echo "$username added to group $group."
				;;
			*)
				echo "invalid operation"
				;;
		esac
	else
		echo "User $username does not exist."
	fi
}

group_management() {
	echo "Group management options : "
	echo "Press 1 to create a group"
	echo "press 2 to delete a group"
	echo "press 3 to add a user to a group"
	echo "press 4 to remove a user from the group"
	read -p "Choose an option : " option

	case $option in
		1)
			read -p "Enter the name of the group you want to create : " groupname
			sudo groupadd "$groupname"
			echo "Group $groupname added succesfully"
			;;
		2)
			read -p "Enter the name of the group you want to delete : " group_delete
			if id "$group_delete" &>/dev/null; then
				sudo groupdel "$group_delete"
				echo "group $group_delete has been deleted succesfully"
			else
				echo "Group $groupdelete does not exist."
			fi
			;;
		3)
			read -p "Enter the name of the user you want to add : " add_user
			read -p "Enter the name of the group in which you want to add the user : " group_name
			if id "$group_name" &>/dev/null; then
				 sudo usermod -aG "$group_name" "$user_name"
				 echo "$add_user added succesfully to group $group_name"
			else
				echo "There is no group named $group_name"
			fi
			;;
		4)
			read -p "Enter the name of the user you want to remove : " remove_user
                        read -p "Enter the name of the group from which you want to remove the user : " remove_group_name
                        if id "$remove_group_name" &>/dev/null; then
                                 sudo gpasswd -d "$remove_user" "$remove_group_name"  
                                 echo "removed $remove_user  succesfully from group $remove_group_name"
                        else
                                echo "There is no group named $removed_group_name"
                        fi
                        ;;
		*)
			echo "Invalid Operation Selected"
			;;
	esac
}

dir_backup() {
	read -p "Enter the directory you want to backup: " directory
	if [ -d "$directory" ]; then 
		tar -czvf backup_$(date +Y%m%d).tar.gz $directory
		echo "Backup of $directory completed succusesfully."
	else
		echo "The directory you have provided does not exist!"
	fi
}

while true; do
	echo " press 1 to add user "
	echo " press 2 to delete user "
	echo " press 3 to modify  user "
	echo " press 4 to manage group "
	echo " press 5 to take backup of a directory"
	echo " press 6 to exit "
	read -p "chose an option : " option
	case $option in 
		1)
			add_user ;;
		2)
			remove_user ;;
		3)
			modify_user ;;
		4)
			group_management ;;
		5)
			dir_backup ;;
		6)
			exit 0 ;;
		*)
			echo "Invalid operation!"
	esac
done

