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

clear_screen() {
    printf "\033c" 
}

banner() {
printf """${cyan}
.----------------------------------------------.
|  ░▀█▀░█░░░█▀▀░░░█▀▀░█░█░█▀▀░█▀▀░█░█░█▀▀░█▀▄  |
|  ░░█░░█░░░▀▀█░░░█░░░█▀█░█▀▀░█░░░█▀▄░█▀▀░█▀▄  |
|  ░░▀░░▀▀▀░▀▀▀░░░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀  |
'----------------------------------------------' ${RESET}                                                                                  
                                      ${GREEN}@srithar${RESET}                 
  """
}


if [ "$#" -eq 0 ]; then
  banner    
  echo -e "${RED}Usage: $0 <domain>.com (or) www.domain.com ${RESET}"
  exit
fi

domain="$1"

w0="Protocol  : TLSv1.1"
w1="Protocol  : TLSv1.2"
w2="Protocol  : TLSv1.3"

banner

echo "*********************************************"
echo -e "       ${RED}Domain provided:${RESET} ${GREEN}$domain${RESET}" 
echo "  *********************************************"

#output3=$(echo | gnutls-cli $domain | grep Status | awk '{print $3, $4, $5, $6, $7, $8, $9, $10, $11, $12}')
output2=$(curl -v --tlsV1.2 https://$domain > output.log 2>&1)
output11=$(curl -v --tlsV1.2 https://$domain > output4.log 2>&1)

output1=$(cat output4.log | grep "Connected" | awk '{print $4, $5, $6, $7, $8}')
#output1=$(echo | gnutls-cli $domain | grep Connecting | awk '{print $3}') 
#output2=$(echo | gnutls-cli $domain | grep Description | awk '{print $3}')

output4=$(cat output.log | grep "SSL connection" | awk '{print $3, $4, $5, $6, $7, $8, $9, $10, $11, $12}')

printf '\n'
printf "${GREEN}Connected IP: " 
echo -e "${YELLOW}$output1${RESET}"

printf "${GREEN}Your Domain SSL: " 
echo -e "${YELLOW}$output4${RESET}"

#printf "${GREEN}Status:" 
#echo -e "${YELLOW}$output3${RESET}"
printf '\n'


echo """--------------------------------------------------"""
echo -e "${RED}Checking Which Versions Present:${RESET}"
printf '\n'

tlsv1=$(openssl s_client -connect $domain:443 -tls1_1 -timeout > output1.log 2>&1)
v1=$(cat output1.log | grep "Protocol  : TLSv1.1")

if [[ "$v1" =~ $w0 ]]; then

  printf "TLSv1.1 is present.  - ${RED}High${RESET}\n"
else
   printf "TLSv1.1 not present. - ${blue}Info${RESET}\n"
fi


tlsv2=$(openssl s_client -connect $domain:443 -tls1_2 -timeout > output2.log 2>&1)

v2=$(cat output2.log | grep "Protocol  : TLSv1.2")

if [[ "$v2" =~ $w1 ]]; then
 
  printf "TLSv1.2 is present.  - ${YELLOW}Medium${RESET}\n"
else
  printf "TLSv1.2 not present. - ${GREEN}LOW${RESET}\n"
fi


tlsv3=$(openssl s_client -connect $domain:443 -tls1_3 -timeout > output3.log 2>&1)

v3=$(cat output3.log | grep "Protocol  : TLSv1.3")
if [[ "$v3" =~ $w2 ]]; then
 
  printf "TLSv1.3 is present.  - ${blue}Info${RESET}\n"
else
 printf "TLSv1.3 not present. - ${RED}High${RESET}\n"
fi

rm output.log output1.log output2.log output3.log output4.log

printf "\n"
o="Darwin"
os=$(uname -a | awk '{print $1}')
if [[ "$o" =~ $os ]]; then
echo """----------------------------------------------------------------------------------------"""
echo -e "${RED}Checking Vulnerabilities: ${RESET}"
printf "\n"
t=$(testssl.sh -H $domain:443 | awk '/(CVE-2014-0160)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t\n"
t1=$(testssl.sh -I $domain:443 | awk '/(CVE-2014-0224)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t1\n"
t2=$(testssl.sh -T $domain:443 | awk '/(CVE-2016-9244)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t2\n"
t3=$(testssl.sh -BB $domain:443 | awk '/ROBOT / {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t3\n"
t4=$(testssl.sh -R $domain:443 | awk '/Secure/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t4\n"
t5=$(testssl.sh -C $domain:443 | awk '/(CVE-2012-4929)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t5\n"
t6=$(testssl.sh -B $domain:443 | awk '/(CVE-2013-3587)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t6\n"
t7=$(testssl.sh -O $domain:443 | awk '/(CVE-2014-3566)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/' | awk '!/ Testing for TLS_FALLBACK_SCSV Protection/')
printf "$t7\n"
t15=$(testssl.sh -Z $domain:443 | awk '/RFC/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/' )
printf "$t15\n"
t8=$(testssl.sh -W $domain:443 | awk '/(CVE-2016-2183, CVE-2016-6329)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t8\n"
t9=$(testssl.sh -A $domain:443 | awk '/(CVE-2011-3389)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t9\n"
t10=$(testssl.sh -L $domain:443 | awk '/(CVE-2013-0169)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t10\n"
t11=$(testssl.sh -W $domain:443 | awk '/(CVE-2014-6321)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t11\n"
t12=$(testssl.sh -F $domain:443 | awk '/(CVE-2015-0204)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t12\n"
t13=$(testssl.sh -J $domain:443 | awk '/(CVE-2015-4000)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/') 
printf "$t13\n"
t14=$(testssl.sh -D $domain:443 | awk '/(CVE-2016-0800, CVE-2016-0703)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t14\n"
else
echo """----------------------------------------------------------------------------------------"""
echo -e "${RED}Checking Vulnerabilities: ${RESET}"
printf "\n"
t=$(testssl -H $domain:443 | awk '/(CVE-2014-0160)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t\n"
t1=$(testssl -I $domain:443 | awk '/(CVE-2014-0224)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t1\n"
t2=$(testssl -T $domain:443 | awk '/(CVE-2016-9244)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t2\n"
t3=$(testssl -BB $domain:443 | awk '/ROBOT / {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t3\n"
t4=$(testssl -R $domain:443 | awk '/Secure/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t4\n"
t5=$(testssl -C $domain:443 | awk '/(CVE-2012-4929)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t5\n"
t6=$(testssl -B $domain:443 | awk '/(CVE-2013-3587)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t6\n"
t7=$(testssl -O $domain:443 | awk '/(CVE-2014-3566)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/' | awk '!/ Testing for TLS_FALLBACK_SCSV Protection/')
printf "$t7\n"
t15=$(testssl -Z $domain:443 | awk '/RFC/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/' )
printf "$t15\n"
t8=$(testssl -W $domain:443 | awk '/(CVE-2016-2183, CVE-2016-6329)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t8\n"
t9=$(testssl -A $domain:443 | awk '/(CVE-2011-3389)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t9\n"
t10=$(testssl -L $domain:443 | awk '/(CVE-2013-0169)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t10\n"
t11=$(testssl -W $domain:443 | awk '/(CVE-2014-6321)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t11\n"
t12=$(testssl -F $domain:443 | awk '/(CVE-2015-0204)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t12\n"
t13=$(testssl -J $domain:443 | awk '/(CVE-2015-4000)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/') 
printf "$t13\n"
t14=$(testssl -D $domain:443 | awk '/(CVE-2016-0800, CVE-2016-0703)/ {print; getline; print; getline; print}' | awk '!seen[$0]++' | awk '!/Done/')
printf "$t14\n"
fi

echo """--------------------------------------------------------------------------------------------"""

echo -e ""
echo -e "${RED}                             〄 ${RESET} ${GREEN} Scan completed. ${RESET} ${RED} 〄 ${RESET}"
