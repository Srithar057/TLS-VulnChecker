#!/bin/bash
RED='\033[1;31m'
REDB='\e[41m'
GREEN='\033[1;32m'
GREENB='\e[42m'
YELLOW='\033[1;33m'
YELLOWB='\e[103m'
RESET='\033[0m'
BLUEB='\e[44m'
blue='\033[1;34m'
MAGENTA='\e[1;35m%s\e[0m\n'
cyan='\e[96m'
printf "\n"
linux() {

required_tools=("openssl" "gnutls-bin" "testssl")
echo """--------------------------------------------------"""
count_installed=0
for tool in "${required_tools[@]}"; do
    if command -v "$tool" &> /dev/null; then
        echo "$tool is installed."
        ((count_installed++))
    else
        echo "$tool is not installed."
    fi
done
echo """--------------------------------------------------"""
if [ "$count_installed" -ge 1 ]; then
    printf "${GREEN}All required tools are already installed.${RESET}\n"
else
    echo "${RED}\nNot all required tools are installed.${RESET}\n"
    printf "\n"
    printf "required tools are installing"
sleep 1
printf "."
sleep 1
printf "."
sleep 1
printf "."
sleep 1
printf "."

printf "\n"
echo -e "${GREEN}Requirement tools installed${RESET}"
fi
    tool1=$(sudo apt install testssl gnutls-bin openssl -y)
    tool2=$(sudo apt install testssl.sh gnutls-bin openssl -y)
}

mac() {
    printf "${RED}Required Tools:${RESET}\n"
echo """-----------------------------------"""
required_tools=("openssl" "gnutls-cli" "testssl.sh")

count_installed=0
for tool in "${required_tools[@]}"; do
    if command -v "$tool" &> /dev/null; then
        echo "$tool is installed."
        ((count_installed++))
    else
        echo "$tool is not installed."
    fi
done
echo """-----------------------------------"""


printf "\n"

if [ "$count_installed" -ge 1 ]; then
    printf "${GREEN}All required tools are already installed.${RESET}\n"
else
    echo "${RED}\nNot all required tools are installed.${RESET}\n"
printf "\n"
printf "required tools are installing"
sleep 1
printf "."
sleep 1
printf "."
sleep 1
printf "."
sleep 1
printf "."
printf "\n"
echo -e "${GREEN}Requirement tools installed${RESET}"
fi

tool1=$(brew install testssl gnutls openssl > .output.log 2>&1)
rm .output.log


}


o="Darwin"
os=$(uname -a | awk '{print $1}')
if [[ "$o" =~ $os ]]; then
mac

else
linux

fi

chmod 777 Tlschecker.sh
