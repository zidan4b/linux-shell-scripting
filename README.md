# Linux Shell Scripting Project

## Overview
This project demonstrates practical Linux system administration and troubleshooting skills using Bash shell scripting.  
It contains multiple interactive scripts designed to simplify common Linux tasks for both administrators and beginner users through structured control flow and standard Linux commands.

---

## Scripts Included

### manage_users.sh
- Interactive, menu-driven user administration tool
- Uses a `while` loop and `case` statement for continuous operation
- Creates, modifies, and deletes user accounts
- Manages primary and supplementary groups
- Updates login shells and account expiration dates
- **Requires sudo privileges**

---

### user_info.sh
- Displays system account details for a specified user
- Reads and parses data from `/etc/passwd`
- Shows UID, GID, home directory, and login shell
- Calculates and displays home directory size

---

### easy_control.sh
- Beginner-friendly Linux control and troubleshooting script
- Provides an interactive menu for common system tasks
- Designed to solve everyday command-line usability problems

**Features:**
- System summary (user, uptime, disk, memory)
- Find largest files in the current directory
- Search text inside files
- Create backups (`tar.gz`)
- Change file permissions (`chmod`)
- Search running processes
- Kill a process by PID with confirmation

---

## Skills & Technologies
- Linux (Ubuntu)
- Bash / Shell Scripting
- Control structures (`while`, `case`, conditionals)
- User and group management
- File permissions and process management
- Command-line utilities and system files
