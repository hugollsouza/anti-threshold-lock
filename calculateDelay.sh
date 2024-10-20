#!/bin/bash
#Calculate delay between kerbrute executions.

# Counting number of users and passwords
NUM_USERS=$(wc -l < "$USERLIST")
NUM_PASSWORDS=$(wc -l < "$PASSWORDLIST")


read -p "Enter the lockout threshold: " LOCKOUT_THRESHOLD
# Setting the lockout threshold to 3 if it is less than 3.
if [ "${LOCKOUT_THRESHOLD}" -le 2 ]; then
  LOCKOUT_THRESHOLD_SAFE=3
else
  LOCKOUT_THRESHOLD_SAFE=$((LOCKOUT_THRESHOLD - 2))
fi
read -p "Enter the lockout reset time in minutes: " LOCKOUT_RESET_TIME_MIN

# Calculating the necessary delay (lockout reset time in seconds)
LOCKOUT_TIME_SEC=$((LOCKOUT_RESET_TIME_MIN * 60))
DELAY=$((LOCKOUT_TIME_SEC / (NUM_USERS * (LOCKOUT_THRESHOLD_SAFE))))

