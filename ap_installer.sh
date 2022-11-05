#!/bin/sh
# wget -q "--no-check-certificate" https://github.com/digiteng/APproject/raw/master/ap_installer.sh -O - | /bin/sh
echo ""
sleep 1
wget github.com/digiteng/APproject/releases/latest/download/ap.tar.gz -P /tmp
echo ""
sleep 1
if [ -f /tmp/ap.tar.gz ]; then
	echo -e "\e[32mNew Version Installing...\e[0m"
	openssl enc -d -aes256 -in /tmp/ap.tar.gz | tar xz -C /
fi
echo ""
sleep 2
echo "end"
exit 0
