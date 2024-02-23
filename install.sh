#!/bin/bash


linux() {

required_tools=("openssl" "gnutls-bin" "testssl")

count_installed=0
for tool in "${required_tools[@]}"; do
    if command -v "$tool" &> /dev/null; then
        echo "$tool is installed."
        ((count_installed++))
    else
        echo "$tool is not installed."
    fi
done

if [ "$count_installed" -ge 3 ]; then
    echo "All required tools are installed."
else
    echo "Not all required tools are installed."
fi
    tool1=$(sudo apt install testssl gnutls-bin openssl -y)
    tool2=$(sudo apt install testssl.sh gnutls-bin openssl -y)

}

mac() {
    
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

if [ "$count_installed" -ge 3 ]; then
    echo "All required tools are installed."
else
    echo "Not all required tools are installed."
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
