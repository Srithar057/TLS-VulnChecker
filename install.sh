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

kali(){
required_tools=("openssl" "gnutls-cli" "testssl")
printf "${RED}Required Tools:${RESET}\n"
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
if [ "$count_installed" -ge 3 ]; then
    printf "${GREEN}All required tools are already installed.${RESET}\n"
else
    echo -e "${RED}\nNot all required tools are installed.${RESET}\n"
    printf "required tools are installing"
    cmd1=$(sudo apt install testssl.sh gnutls-bin openssl -y &> /dev/null)
    cmd2=$(sudo apt-get install --reinstall ca-certificates &> /dev/null)
    cmd3=$(sudo update-ca-certificates --fresh &> /dev/null)
    printf "\n"
    printf "\n"
    for ((i = 0; i < 50; i++)); do
    sleep 0.1
    printf "${cyan}▇${RESET}"
    done
    echo -e "${GREEN} Done!${RESET}"
    printf "\n"
    #echo -e "${GREEN}Requirement tools installed${RESET}"
fi

}

ubuntu(){
required_tools=("openssl" "gnutls-cli" "testssl")
printf "${RED}Required Tools:${RESET}\n"
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
if [ "$count_installed" -ge 3 ]; then
    printf "${GREEN}All required tools are already installed.${RESET}\n"
else
    echo -e "${RED}\nNot all required tools are installed.${RESET}\n"
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
    cmd1=$(sudo apt install testssl.sh gnutls-bin openssl -y &> /dev/null)
    cmd2=$(sudo apt-get install --reinstall ca-certificates &> /dev/null)
    cmd3=$(sudo update-ca-certificates --fresh &> /dev/null)
     printf "\n"
    printf "\n"
    for ((i = 0; i < 50; i++)); do
    sleep 0.1
    printf "${cyan}▇${RESET}"
    done
    echo -e "${GREEN} Done!${RESET}"
    printf "\n"
    #echo -e "${GREEN}Requirement tools installed${RESET}"
fi
    

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

if [ "$count_installed" -ge 3 ]; then
    printf "${GREEN}All required tools are already installed.${RESET}\n"
else
    echo -e "${RED}\nNot all required tools are installed.${RESET}\n"
    printf "\n"
    printf "required tools are installing"
    brew install testssl gnutls openssl > .output.log 2>&1
    brew link --force openssl
    rm .output.log
    printf "\n"
    for ((i = 0; i < 50; i++)); do
    sleep 0.1
    printf "${cyan}▇${RESET}"
    done
    echo -e "${GREEN} Done!${RESET}"
    printf "\n"
    #echo -e "${GREEN}Requirement tools installed${RESET}"
fi
}


k="Kali"
kf=$(lsb_release -d | grep "Kali" | awk '{print $2}')
u="Ubuntu"
uf=$(lsb_release -d | grep "Ubuntu" | awk '{print $2}')
m="Darwin"
os=$(uname -a | awk '{print $1}')

if [ -n "$os" ] && [ "$os" = "$m" ]; then 
    mac
elif [ -n "$kf" ] && [ "$kf" = "$k" ]; then
    kali
elif [ -n "$uf" ] && [ "$uf" = "$u" ]; then
    ubuntu
else
    printf "The tool currently tested only Kali, Ubuntu, Mac."
fi

chmod 777 Tlschecker.sh

echo """--------------------------------------------------------------------------------------------"""

echo -e ""
echo -e "${RED}                             〄 ${RESET} ${GREEN} Installation completed. ${RESET} ${RED} 〄 ${RESET}"
