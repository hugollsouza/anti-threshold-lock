#!/bin/bash
# Function to display help message
show_help() {
  echo "Usage: $0 -uL <userlist file> -pL <passwordlist file> -d <domain> -dc <IP> -t <threads>"
  echo
  echo "Parameters:"
  echo "  -uL <userlist file>      - Path to the userlist file."
  echo "  -pL <passwordlist file>  - Path to the passwordlist file."
  echo "  -d, --domain <domain>    - A valid domain (e.g., example.com)."
  echo "  -dc <IP>                 - A valid IP address for the Domain Controller (e.g., 192.168.0.1)."
  echo "  -t, --threads <threads>  - A number between 1 and 200."
  exit 1
}

# Variable to store errors
errors=""

# Variables for the parameters
USERLIST=""
PASSWORDLIST=""
DOMAIN=""
DC_IP=""
THREADS=""

# Parsing command-line options
while [[ $# -gt 0 ]]; do
  case "$1" in
    -uL)
      USERLIST="$2"
      shift 2
      ;;
    -pL)
      PASSWORDLIST="$2"
      shift 2
      ;;
    -d|--domain)
      DOMAIN="$2"
      shift 2
      ;;
    -dc)
      DC_IP="$2"
      shift 2
      ;;
    -t|--threads)
      THREADS="$2"
      shift 2
      ;;
    -h|--help)
      show_help
      ;;
    *)
      errors+="Error: Invalid option '$1'.\n"
      shift
      ;;
  esac
done

# Check if the userlist files is valid
  if [ ! -f "$USERLIST" ]; then
    errors+="Error: The file 'userlist' does not exist or is not a valid file.\n"
  fi

# Check if the passwordlist files is valid
if [ ! -f "${PASSWORDLIST}" ]; then
  errors+="Error: The file 'passwordlist' does not exist or is not a valid file.\n"
fi

# Domain validation using case (simple regex)
case "${DOMAIN}" in
  *[a-zA-Z0-9.-]*.[a-zA-Z]*) 
    # Valid domain
    ;;
  *)
    errors+="Error: The domain '${DOMAIN}' is not valid.\n"
    ;;
esac

# IP validation using case
case "${DC_IP}" in
  [0-9]*.[0-9]*.[0-9]*.[0-9]*) 
    IFS='.' read -r -a octets <<< "${DC_IP}"
    for octet in "${octets[@]}"; do
      if ! [[ "$octet" =~ ^[0-9]+$ ]] || [ "$octet" -lt 0 ] || [ "$octet" -gt 255 ]; then
        errors+="Error: The IP address '${DC_IP}' contains values outside the allowed range (0-255).\n"
        break
      fi
    done
    ;;
  *)
    errors+="Error: The IP address '${DC_IP}' is not valid.\n"
    ;;
esac



# Display help and errors if any
if [ -n "$errors" ]; then
  echo -e "$errors"
  echo -e "Use the ${0} -h or --help option to display help."
  exit 1
fi
