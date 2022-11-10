#!/bin/sh
# wget -q "--no-check-certificate" https://github.com/digiteng/APproject/raw/main/ap_installer.sh -O - | /bin/sh
echo ""
sleep 1
echo -e "\e[32mOld Version Deleting...\e[0m"
rm -rf /usr/lib/enigma2/python/Plugins/Extensions/AudioPlus
rm -rf /ap.tar.gz
echo -e "\e[32mOld Version Deleted\e[0m"
sleep 1
wget -q "github.com/digiteng/APproject/releases/latest/download/ap.tar.gz" -P /tmp
sleep 5
echo -e "\e[32mNew Version Downloaded\e[0m"
sleep 1
echo -e "\e[32mNew Version Installing...\e[0m"
if [ -f /tmp/ap.tar.gz ]; then
	openssl enc -d -aes256 -in /tmp/ap.tar.gz | tar xz -C /tmp
fi
exit 0
