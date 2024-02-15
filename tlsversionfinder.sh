#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'
blue='\e[1;34m%s\e[0m\n'
MAGENTA='\e[1;35m%s\e[0m\n'
cyan='\e[1;36m%s\e[0m\n'

clear_screen() {
    printf "\033c" 
}
clear_screen
banner() {
echo """

 ███████████ █████        █████████       █████████  █████                        █████                        
░█░░░███░░░█░░███        ███░░░░░███     ███░░░░░███░░███                        ░░███                         
░   ░███  ░  ░███       ░███    ░░░     ███     ░░░  ░███████    ██████   ██████  ░███ █████  ██████  ████████ 
    ░███     ░███       ░░█████████    ░███          ░███░░███  ███░░███ ███░░███ ░███░░███  ███░░███░░███░░███
    ░███     ░███        ░░░░░░░░███   ░███          ░███ ░███ ░███████ ░███ ░░░  ░██████░  ░███████  ░███ ░░░ 
    ░███     ░███      █ ███    ░███   ░░███     ███ ░███ ░███ ░███░░░  ░███  ███ ░███░░███ ░███░░░   ░███     
    █████    ███████████░░█████████     ░░█████████  ████ █████░░██████ ░░██████  ████ █████░░██████  █████    
   ░░░░░    ░░░░░░░░░░░  ░░░░░░░░░       ░░░░░░░░░  ░░░░ ░░░░░  ░░░░░░   ░░░░░░  ░░░░ ░░░░░  ░░░░░░  ░░░░░     
                                                                                                               
                                                                                                               
  Usage: ./Tlschecker.sh domain.com

"""
}

banner
printf "............................${GREEN}Please wait for the result${RESET}............................\n"
if [ "$#" -eq 0 ]; then
  echo -e "${RED}Usage: $0 <domain>.com${RESET}"

fi
printf ""
domain="$1"
w0="Protocol  : TLSv1.1"
w1="Protocol  : TLSv1.2"
w2="Protocol  : TLSv1.3"

tlsv1=$(openssl s_client -connect $domain:443 -tls1_1 -timeout)

tlsv2=$(openssl s_client -connect $domain:443 -tls1_2 -timeout)

tlsv3=$(openssl s_client -connect $domain:443 -tls1_3 -timeout)

clear_screen

banner

echo """*********************************************"""
echo -e "       ${RED}Domain provided:${RESET} ${GREEN}$domain${RESET}" 
echo """*********************************************
"""
output1=$(echo | gnutls-cli $domain | grep Connecting | awk '{print $3}') 
output2=$(echo | gnutls-cli $domain | grep Description | awk '{print $3}')
output3=$(echo | gnutls-cli $domain | grep Status | awk '{print $3, $4, $5, $6, $7, $8, $9, $10, $11, $12}')

printf '\n'
printf "${GREEN}Connecting IP:" 
echo -e "${YELLOW}$output1${RESET}"

printf "${GREEN}Your Domain Using TLS Version:" 
echo -e "${YELLOW}$output2${RESET}"

printf "${GREEN}Status:" 
echo -e "${YELLOW}$output3${RESET}"
printf '\n'
echo -e "${RED}Still Your Domain Using Below Versions.${RESET}"
printf ""
if [[ "$tlsv1" =~ $w0 ]]; then

  echo "TLSv1.1 is present"
else
   echo "TLSv1.1 not present."
fi

if [[ "$tlsv2" =~ $w1 ]]; then
 
  echo "TLSv1.2 is present"
else
  echo "TLSv1.2 not present."
fi

if [[ "$tlsv3" =~ $w2 ]]; then
 
  echo "TLSv1.3 is present"
else
 echo "TLSv1.3 not present."

fi


echo -e "${RED}               ✿  ${RESET} ${GREEN} Scan completed. ${RESET} ${RED}  ✿ ${RESET}"