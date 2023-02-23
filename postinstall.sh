#!/usr/bin/env bash
#
# postinstall.sh - Install and configure programs on Linux
#
# ----------------------------- VARIABLES ----------------------------- #
set -e


#COLORS

RED='\e[1;91m'
GREEN='\e[1;92m'
NO_COLOR='\e[0m'


#functions

#Updating repository and doing system update

apt_update(){
  sudo apt update && sudo apt dist-upgrade && sudo service packagekit restart -y
}

# -------------------------------TESTS AND REQUIREMENTS----------------------------------------- #

# Internet conectando?
internet_tests(){
if ! sudo ping -c 1 google.com > /dev/null; then
  echo -e "${RED}[ERROR] - Your computer does not have an Internet connection. check the network.${NO_COLOR}"
  exit 1
else
  echo -e "${GREEN}[INFO] - Internet connection working normally.${NO_COLOR}"
fi
}

# ------------------------------------------------------------------------------ #

## Updating the repository ##
just_apt_update(){
sudo apt update -y
}

# ---------------------------------------------------------------------- #

## Downloading and installing external programs ##

install_debs(){
# Install programs in apt #
echo -e "${GREEN}[INFO] - Installing apt packages from repository${NO_COLOR}"

  apt install snapd -y 
  apt install winff -y
  apt install ratbagd -y
  apt install gparted -y
  apt install gufw -y
  apt install synaptic -y
  apt install vlc -y
  apt install code -y
  apt install gnome-sushi -y
  apt install folder-color -y
  apt install git -y
  apt install wget -y
  apt install ubuntu-restricted-extras -y
  apt install v4l2loopback-utils -y
  apt install file-roller -y
  apt install tlp -y
  apt install nodejs -y
  apt install npm -y
  apt install python3 -y
  apt install python3-pip -y
  apt install default-jdk -y
  apt install openvpn -y
  apt install software-properties-common -y
  apt install php -y
  
}
## Installing Flatpak packages ##
install_flatpaks(){

  echo -e "${GREEN}[INFO] - Installing flatpak packages${NO_COLOR}"

 flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo -y
 flatpak install flathub com.spotify.Client -y
 flatpak install flathub com.bitwarden.desktop -y
 flatpak install flathub org.freedesktop.Piper -y
 flatpak install flathub org.gnome.Boxes -y
 flatpak install flathub org.onlyoffice.desktopeditors -y
 flatpak install flathub org.qbittorrent.qBittorrent -y
 flatpak install flathub org.flameshot.Flameshot -y
 flatpak install flathub com.discordapp.Discord -y
 flatpak install flathub us.zoom.Zoom -y
 flatpak install flathub com.github.tchx84.Flatseal -y
 flatpak install flathub com.getpostman.Postman -y
 flatpak install flathub com.github.d4nj1.tlpui -y
 flatpak install flathub dev.k8slens.OpenLens -y

}

## Installing Snap packages ##

install_snaps(){

echo -e "${GREEN}[INFO] - Installing snap packages${NO_COLOR}"

sudo snap install authy
sudo snap install docker
sudo snap install aws-cli --classic
sudo snap install google-cloud-cli --classic
sudo snap install google-cloud-sdk --classic
sudo snap install kontena-lens --classic
sudo snap install azure-cli-johanburati
sudo snap install azure-functions-core-tools-johanburati
sudo snap install slack
sudo snap install chromium

}

# ----------------------------- POST-INSTALLATION ----------------------------- #

## Finishing, updating and cleaning##

system_clean(){

apt_update -y
flatpak update -y
sudo apt autoclean -y
sudo apt autoremove -y
nautilus -q
}

# -------------------------------EXECUTION----------------------------------------- #

internet_tests
apt_update
just_apt_update
install_debs
install_flatpaks
install_snaps
apt_update
system_clean

## The End ##

  echo -e "${GREEN}[INFO] - Script finished, installation complete! :)${NO_COLOR}"
