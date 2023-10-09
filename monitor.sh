#!/bin/bash

# Define the PM2 process IDs you want to monitor.
PM2_PROCESS_IDS="1"

# Function to check and restart PM2 processes by ID
check_and_restart_pm2_by_id() {
    for process_id in $PM2_PROCESS_IDS; do
        status=$(pm2 show $process_id | grep "status" | awk '{print $4}')
        
        if [ "$status" != "online" ]; then
            echo "[$(date +'%Y-%m-%d %H:%M:%S')] PM2 process with ID $process_id is not in 'online' status. Restarting..."
            pm2 restart $process_id
        else
             echo "status is online."
         
        fi
    done
}

# Main loop to continuously check and restart PM2 processes by ID
while true; do
    check_and_restart_pm2_by_id
    sleep 10  # Adjust the sleep interval as needed
done
