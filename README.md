## Linux Shell Scripting Project

## Overview
- This project demonstrates practical Linux system administration skills using Bash shell scripting.
It includes two scripts that focus on user management and system account information, implemented with structured control flow and standard Linux commands.

## Scripts Included

## manage_users.sh
- Interactive, menu-driven user administration tool
- Uses a while loop and case statement for continuous operation
- Creates, modifies, and deletes user accounts
- Manages primary and supplementary groups
- Updates login shells and account expiration dates

## user_info.sh
- Displays system account details for a specified user
- Reads and parses data from /etc/passwd
- Shows UID, GID, home directory, and login shell
- Calculates and displays home directory size

## Skills & Technologies
- Linux (Ubuntu)
- Bash / Shell Scripting
- Control structures (loops, case statements)
- User and group management
- Command-line utilities and system files

## How to Run
- chmod +x manage_users.sh user_info.sh
./manage_users.sh

- ./user_info.sh username

## Note: manage_users.sh requires sudo privileges for administrative tasks.
