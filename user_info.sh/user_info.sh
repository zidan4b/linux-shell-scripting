#!/bin/sh -u
PATH=/bin:/usr/bin ; export PATH
umask 022

# Author: Zidan Bakari
# Script: user_info.sh
# This script displays account information for a given username using /etc/passwd.
# It also calculates and shows the size of the user’s home directory in KB.



USERINFO=$(grep "^$1:" /etc/passwd 2>/dev/null)

USERNAME=$(echo $USERINFO | cut -d ":" -f1)
USER_UID=$(echo $USERINFO | cut -d ":" -f3)
USER_GID=$(echo $USERINFO | cut -d ":" -f4)
COMMENT=$(echo $USERINFO | cut -d ":" -f5)
HOME_DIRECTORY=$(echo $USERINFO | cut -d ":" -f6)
SHELL_PATH=$(echo $USERINFO | cut -d ":" -f7)

SIZE_BYTE=$(stat -c %s $HOME_DIRECTORY 2>/dev/null)
SIZE_KB=$((SIZE_BYTE / 1024 ))



echo "Username: $USERNAME"
echo "UID (User ID): $USER_UID"
echo "GID (Group ID): $USER_GID"
echo "The comment field: $COMMENT"
echo "Home directory: $HOME_DIRECTORY"
echo "Path to shell: $SHELL_PATH" 
echo "Home directory size (KB): $SIZE_KB"

echo "Current User: $USER"
echo "Current Home Directory: $HOME"



