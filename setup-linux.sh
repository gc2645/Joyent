#!/bin/bash
clear

# Create a secure tmp directory
tmp=${TMPDIR-/tmp}
	tmp=$tmp/oduso.$RANDOM.$RANDOM.$RANDOM.$$ # Use a random name so it's secure
	(umask 077 && mkdir "$tmp") || { # Another security precaution
		echo "Could not create temporary directory! Exiting." 1>&2 
		exit 1
	}

# Checks if the system is 64bit or 32bit
[[ $(uname -m) == x86_64 ]] && arch=amd64 || arch=i386

if [ $(tput colors) ]; then # Checks if terminal supports colors
	red="\e[31m"
	green="\e[32m"
	endcolor="\e[39m"
fi

distro=$(lsb_release -c | cut -f2)
targetDistro=freya
if [ "$distro" != "$targetDistro" ]; then
  echo "Wrong Distribution!"
  echo "You are using $distro, this script was made for $targetDistro."
  echo "Please visit oduso.com"
  exit 1
fi

echo --------------------------------------------------------------------------------
echo "We are not responsible for any damages that may possibly occur while using ODUSO"
echo --------------------------------------------------------------------------------
echo "   "

#use sudo rights for the whole script
sudo -s <<ODUSO

clear

echo ------------------
echo "Welcome to ODUSO"
echo ------------------
echo "   "
sleep 2

trap "rm -rf $tmp" EXIT # Delete tmp files on exit

# Add all the repositories
echo "Adding Repositories" 
(
apt-add-repository ppa:videolan/stable-daily -y
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
apt-add-repository ppa:otto-kesselgulasch/gimp -y
apt-add-repository ppa:teejee2008/ppa -y
apt-add-repository ppa:transmissionbt/ppa -y
apt-add-repository ppa:libreoffice/libreoffice-4-3 -y
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886 && echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list
apt-add-repository ppa:mozillateam/thunderbird-next -y
apt-add-repository ppa:me-davidsansome/clementine -y
apt-add-repository ppa:ubuntu-wine/ppa -y
apt-add-repository ppa:mpstark/elementary-tweaks-daily -y
apt-add-repository ppa:thefanclub/grive-tools -y
sudo apt-add-repository ppa:versable/elementary-update
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

#Clean-up System
echo "Cleaning Up Shitty Elementary Apps"
(
sudo apt-get purge midori-granite
sudo apt-get purge noise
sudo apt-get purge scratch-text-editor
sudo apt-get purge bluez
sudo apt-get purge modemmanager
sudo apt-get autoremove
sudo apt-get autoclean

#Remove some Switchboard Plug's
sudo rm -rf /usr/lib/plugs/GnomeCC/gnomecc-bluetooth.plug
sudo rm -rf /usr/lib/plugs/GnomeCC/gnomecc-wacom.plug

#Enable all Startup Applications
cd /etc/xdg/autostart
sudo sed --in-place 's/NoDisplay=true/NoDisplay=false/g' *.desktop

) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Updating System" 
(
apt-get update
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Wine"
(
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
apt-get -y install wine
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing VLC"
(
apt-get -y install vlc
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing GIMP"
(
apt-get -y install gimp
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Conky Manager"
(
apt-get -y install conky-manager
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Transmission"
(
apt-get -y install transmission
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing LibreOffice"
(
apt-get -y install libreoffice
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Spotify"
(
apt-get install spotify-client -y
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Thunderbird Mail"
(
apt-get -y install thunderbird
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Clementine"
(
apt-get -y install clementine
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Chrome"
(
apt-get install google-chrome-stable -y


) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Firefox"
(
apt-get -y install firefox
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Tweaks"
(
apt-get -y install elementary-tweaks
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Dropbox"
(
wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.02.12_$arch.deb -O $tmp/dropbox.deb
dpkg -i $tmp/dropbox.deb
apt-get install -f
apt-get -y install pantheon-files-plugin-dropbox

) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Grive Tools"
(
apt-get install grive-tools -y
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Cleaning up"
(
apt-get -y autoclean 
apt-get -y clean
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Upgrading old packages"
(
apt-get -y upgrade
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing file archiving resources"
(
apt-get install unace rar unrar p7zip-rar p7zip zip unzip sharutils uudeview mpack arj cabextract file-roller -y
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Ubuntu Restricted Extra"
(
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections 
apt-get install ttf-mscorefonts-installer -y 
apt-get install ubuntu-restricted-addons -y 
apt-get install gstreamer0.10-plugins-bad-multiverse -y 
apt-get install libavcodec-extra-53 -y 
apt-get install unrar -y
sudo apt-get install elementary-desktop elementary-tweaks
sudo apt-get install elementary-dark-theme elementary-plastico-theme elementary-whit-e-theme elementary-harvey-theme
sudo apt-get install elementary-elfaenza-icons elementary-nitrux-icons
sudo apt-get install elementary-plank-themes
sudo apt-get install wingpanel-slim indicator-synapse
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

ODUSO
notify-send "Oduso" "Finished installing"
exit 0

