#!/bin/bash
# ==========================================
# EASY LINUX CONTROL SCRIPT
# Author: Zidan Bakari
# Description:
# A simple menu-based Bash script to perform
# common Linux troubleshooting and control tasks.
# ==========================================

# Infinite loop to keep menu running
while true
do
  echo "======================="
  echo "   EASY LINUX CONTROL"
  echo "======================="
  echo "1) System summary"
  echo "2) Find biggest files (current folder)"
  echo "3) Search text in a file"
  echo "4) Backup a file/folder (tar.gz)"
  echo "5) Change file permissions (chmod)"
  echo "6) Process: search"
  echo "7) Process: kill by PID (confirm)"
  echo "8) Exit"
  echo "Choose: "

  # Read user menu choice
  read choice

  # Case statement handles user selection
  case $choice in

    1)
      # ---- SYSTEM SUMMARY ----
      echo "User: $(whoami)"            
      echo "Uptime: $(uptime -p)"      
      echo ""
      echo "Disk:"
      df -h | head -n 6                
      echo ""
      echo "Memory:"
      free -h 2>/dev/null || echo "free not available" 
      ;;

    2)
      # ---- FIND BIGGEST FILES ----
      echo "Top 10 biggest items in current folder:"
      du -ah . 2>/dev/null | sort -rh | head -n 10
      ;;

    3)
      # ---- SEARCH TEXT IN FILE ----
      echo "File name:"
      read file
      if [ -f "$file" ]; then          
        echo "Word to search:"
        read word
        grep -n --color=auto "$word" "$file" || echo "No matches."
      else
        echo "❌ File not found."
      fi
      ;;

    4)
      # ---- BACKUP FILE OR FOLDER ----
      echo "Enter file/folder to backup:"
      read target
      if [ -e "$target" ]; then        
        # Create timestamped backup name
        backup="$(basename "$target")_backup_$(date +%Y%m%d_%H%M%S).tar.gz"
        tar -czf "$backup" "$target"    # Compress into tar.gz
        echo "✅ Backup created: $backup"
      else
        echo "❌ Not found."
      fi
      ;;

    5)
      # ---- CHANGE PERMISSIONS ----
      echo "Enter file/folder name:"
      read item
      if [ -e "$item" ]; then
        echo "Enter permission (example 755 or 644):"
        read perm
        # Validate permission format (3 digits 0-7)
        if [[ "$perm" =~ ^[0-7]{3}$ ]]; then
          chmod "$perm" "$item"
          echo "✅ Permissions changed to $perm"
          ls -l "$item"               
        else
          echo "❌ Invalid permission. Use 3 digits like 755."
        fi
      else
        echo "❌ Not found."
      fi
      ;;

    6)
      # ---- PROCESS SEARCH ----
      echo "Enter process name to search (example: firefox):"
      read pname
      ps -ef | grep -i "$pname" | grep -v grep || echo "No matching process."
      ;;

    7)
      # ---- KILL PROCESS BY PID ----
      echo "Enter PID to kill:"
      read pid
      # Validate PID is numeric
      if [[ "$pid" =~ ^[0-9]+$ ]]; then
        ps -p "$pid" >/dev/null 2>&1
        if [ $? -eq 0 ]; then
          echo "Process info:"
          ps -p "$pid" -o pid,comm,%cpu,%mem
          echo "Type yes to kill it:"
          read confirm
          if [ "$confirm" = "yes" ]; then
            kill "$pid"
            echo "✅ Killed PID $pid"
          else
            echo "Cancelled."
          fi
        else
          echo "❌ PID not found."
        fi
      else
        echo "❌ Invalid PID."
      fi
      ;;

    8)
      # ---- EXIT ----
      echo "Goodbye!"
      break
      ;;

    *)
      # ---- INVALID OPTION ----
      echo "Invalid choice"
      ;;
  esac

  echo "" 
done
