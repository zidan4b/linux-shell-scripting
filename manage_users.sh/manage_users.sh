#********************************************************************
#!/bin/sh -u
PATH=/bin:/usr/bin ; export PATH
umask 022
#
#Purpose: This script offers an easy menu interface 
#for common Linux user-management tasks.
#It allows the admin to create, modify, or remove user accounts through simple options.
#Each choice runs a function that performs the required system command safely and clearly.
#
#Written by: Zidan Bakari, 2025-11-29, manage_users
#
#Algorithm 
#Start the script, display the menu, and read the user’s choice.
#Use a loop and case statement to call the correct function for the selected option.
#Perform the action, show results or errors, wait briefly, and return to the menu until the user quits.
#********************************************************************

SCRIPT_NAME="manage_users"

letter="z"

error_message() {
    echo "$SCRIPT_NAME: ERROR: action failed"
}

menu() {
    clear
    echo "***************************************************"
    echo "              User Administration Menu"
    echo "***************************************************"
    echo "(A-a) Add a user account"
    echo "(I-i) Change a user’s initial/primary group"
    echo "(S-s) Change a user’s supplementary group"
    echo "(L-l) Change a user’s login shell"
    echo "(E-e) Change a user’s expiration date"
    echo "(D-d) Delete a user account"
    echo "(Q-q) Quit"
    echo "***************************************************"
    echo -n "Enter your choice: "
}

#***************************************************************
# A- Creates a new user with a home directory and login shell.
#****************************************************************
opA() {
    clear
    echo "**************************"
    echo "Create a user"
    echo "**************************"

    echo "Please enter a username:"
    read username

    echo "Please enter a home directory (absolute path):"
    read homedir

    echo "Enter a login shell (absolute path):"
    read loginshell

    sudo useradd -d "$homedir" -m -s "$loginshell" "$username"

    if [ $? -ne 0 ]; then
        error_message
    else
        echo "User successfully created:"
        grep "$username" /etc/passwd
    fi
    sleep 3
}

#**************************************************
# I — Changes the user’s initial (primary) group.
#**************************************************
opB() {
    clear
    echo "*******************************************"
    echo "To change the initial group of a user"
    echo "*******************************************"

    echo "Enter the user name:"
    read username

    echo "The user $username belongs to the initial group:"
    id -ng "$username"

    echo "Enter the new initial group name:"
    read igroup

    sudo usermod -g "$igroup" "$username"

    if [ $? -eq 0 ]; then
        echo "Initial group successfully updated. New group:"
        id -gn "$username"
    else
        error_message
    fi
    sleep 3
}

#*******************************************************
# S — Change a supplementary group to the user’s account.
#********************************************************
opC() {
    clear
    echo "***************************************************"
    echo "To change the supplementary group of a user"
    echo "***************************************************"

    echo "Enter username:"
    read username

    echo "Enter supplementary group name:"
    read sgroup

    sudo usermod -aG "$sgroup" "$username"

    if [ $? -eq 0 ]; then
        echo "Supplementary groups for $username:"
        id -Gn "$username"
    else
        error_message
    fi
    sleep 3
}

#***********************************************
# L — Updates the user’s default login shell.
#***********************************************
opD() {
    clear
    echo "***************************************************"
    echo "To change the login shell of a user"
    echo "***************************************************"

    echo "Available shells:"
    cat /etc/shells
    echo ""

    echo "Enter the username:"
    read username

    echo "Enter the user's new login shell:"
    read loginshell

    sudo usermod -s "$loginshell" "$username"

    if [ $? -eq 0 ]; then
        echo "The login shell for $username is now:"
        grep "$username" /etc/passwd
    else
        echo "Could not change login shell for $username"
    fi
    sleep 3
}

#************************************************
# E — Change the user’s account expiration date.
# ************************************************
opE() {
    clear
    echo "***************************************************"
    echo "To change the account expiration date of a user"
    echo "***************************************************"

    echo "Enter the username:"
    read username

    echo "Enter expiration date (YYYY-MM-DD):"
    read edate

    sudo usermod -e "$edate" "$username"

    echo "Updated expiration info:"
    sudo chage -l "$username"

    sleep 3
}

#*************************************************
# D — Deletes a user and their home directory.
#*************************************************
opF() {
    clear
    echo "************************"
    echo "To delete a user"
    echo "************************"

    echo "Users on the system:"
    cat /etc/passwd

    echo "Enter username to delete:"
    read username

    sudo userdel -rf "$username"

    if [ $? -eq 0 ]; then
        echo "Operation successful."
        echo "Users left:"
        cat /etc/passwd
    else
        echo "There was an issue processing your request."
    fi
    sleep 3
}

#*************************************************
# Main loop: Repeats menu actions until quit.
#*************************************************
while [ "$letter" != "q" ] && [ "$letter" != "Q" ]
do
    menu
    read letter
    clear

    case "$letter" in
        A|a) opA ;;  
        I|i) opB ;;  
        S|s) opC ;;  
        L|l) opD ;;  
        E|e) opE ;;  
        D|d) opF ;;  
        Q|q) exit 0 ;;
        *) echo "$SCRIPT_NAME: Invalid menu option" ; sleep 3 ;;
    esac
done

