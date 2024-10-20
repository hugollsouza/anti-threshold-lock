#!/bin/bash
#Calculate delay between kerbrute executions.

# TODO
# Ask for the parameter LOCKOUT_THRESHOLD to user
LOCKOUT_THRESHOLD=$3

# Setting the lockout threshold to 3 if it is less than 3.
if [ "${LOCKOUT_THRESHOLD}" -le 2 ]; then
  LOCKOUT_THRESHOLD=3
fi

# TODO
# Ask for the parameter LOCKOUT_THRESHOLD to user
LOCKOUT_RESET_TIME_MIN=$4

# Calculating the necessary delay (lockout reset time in seconds)
LOCKOUT_TIME_SEC=$((LOCKOUT_RESET_TIME_MIN * 60))
DELAY=$((LOCKOUT_TIME_SEC / (NUM_USERS * (LOCKOUT_THRESHOLD - 2))))

# Counting number of users and passwords
NUM_USERS=$(wc -l < "$USER_LIST")
NUM_PASSWORDS=$(wc -l < "$PASSWORD_LIST")