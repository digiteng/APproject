#!/bin/sh
# wget -q "--no-check-certificate" https://github.com/digiteng/APproject/raw/main/ap_installer.sh -O - | /bin/sh
echo ""
sleep 1
echo -e "\e[32mOld Version Deleting...\e[0m"
rm -rf /usr/lib/enigma2/python/Plugins/Extensions/AudioPlus
rm -rf /ap.tar.gz
echo -e "\e[32mOld Version Deleted\e[0m"
sleep 1
wget -q github.com/digiteng/APproject/releases/latest/download/ap.tar.gz -P /tmp
sleep 5
echo -e "\e[32mNew Version Downloaded\e[0m"
sleep 1
echo -e "\e[32mNew Version Installing...\e[0m"
if [ -f /ap.tar.gz ]; then
	openssl enc -d -aes256 -in /tmp/ap.tar.gz | tar xz -C /tmp
fi
sleep 3
if [ -d /ap ]; then
	mv -v /tmp/ap/asound.conf /etc
	mv -v /tmp/ap/AudioPlus /usr/lib/enigma2/python/Plugins/Extensions/
fi
sleep 3
echo -e "\e[32mNew Version Installed...\e[0m"
if [ -f /var/lib/dpkg ]; then
	OS='Dream'
	ipath="/var/lib/dpkg/status"
else
	OS='OE'
	ipath="/var/lib/opkg/status"
fi
echo""
if [ -f /usr/lib/enigma2/python/Plugins/Extensions/AudioPlus/plugin.py ]; then
	echo -e "\e[32mNew Version Installed\e[0m"
	
	if [ $OS = "Dream" ]; then
		echo -e "\e[32mUpdating...\e[0m"
		apt-get update
		if grep 'gstreamer1.0-plugins-base-volume' $ipath; then
			echo ""
		else
			echo " Downloading gstreamer1.0-plugins-base-volume ......"
			apt-get install gstreamer1.0-plugins-base-volume -y;
		fi
		if grep 'gstreamer1.0-plugins-good-ossaudio' $ipath; then
			echo ""
		else
			echo " Downloading gstreamer1.0-plugins-good-ossaudio ......"
			apt-get install gstreamer1.0-plugins-good-ossaudio -y;
		fi
		if grep 'gstreamer1.0-plugins-good-mpg123' $ipath; then
			echo ""
		else
			echo " Downloading gstreamer1.0-plugins-good-mpg123 ......"
			apt-get install gstreamer1.0-plugins-good-mpg123 -y;
		fi	
		if grep 'gstreamer1.0-plugins-good-equalizer' $ipath; then
			echo ""
		else
			echo " Downloading gstreamer1.0-plugins-good-equalizer ......"
			apt-get install gstreamer1.0-plugins-good-equalizer -y;
		fi		
	else
		echo -e "\e[32mUpdating...\e[0m"
		opkg update
		if grep 'gstreamer1.0-plugins-base-volume' $ipath; then
			echo ""
		else
			echo " Downloading gstreamer1.0-plugins-base-volume ......"
			opkg install gstreamer1.0-plugins-base-volume -y;
		fi
		if grep 'gstreamer1.0-plugins-good-ossaudio' $ipath; then
			echo ""
		else
			echo " Downloading gstreamer1.0-plugins-good-ossaudio ......"
			opkg install gstreamer1.0-plugins-good-ossaudio -y;
		fi
		if grep 'gstreamer1.0-plugins-good-mpg123' $ipath; then
			echo ""
		else
			echo " Downloading gstreamer1.0-plugins-good-mpg123 ......"
			opkg install gstreamer1.0-plugins-good-mpg123 -y;
		fi	
		if grep 'gstreamer1.0-plugins-good-equalizer' $ipath; then
			echo ""
		else
			echo " Downloading gstreamer1.0-plugins-good-equalizer ......"
			opkg install gstreamer1.0-plugins-good-equalizer -y;
		fi
	fi
	sleep 3
	rm -rf /tmp/ap.tar.gz
	rm -rf /tmp/ap
	sleep 2
	echo -e "\e[1;33mRestarting Enigma2 Gui...\e[0m"
	if [ $OS = "Dream" ]; then
		systemctl restart enigma2
	else
		killall -9 enigma2
	fi
else
	echo -e "\e[31mNew Version Failed To Load\e[0m"
fi
exit 0

