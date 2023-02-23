#!/usr/bin/env bash
#
# postinstall.sh - Install and configure programs on Linux
#
# ----------------------------- VARIABLES ----------------------------- #
set -e

##URLS

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"


##DEB SOFTWARES TO INSTALL
SOFTWARES_TO_INSTALL="'snapd' 'winff' 'ratbagd' 'gparted' 'gufw' 'synaptic' 'vlc' 'code' 'gnome-sushi' 'folder-color' 'git' 'wget' 'ubuntu-restricted-extras' 'v4l2loopback-utils' 'file-roller' 'tlp' 'nodejs' 'npm' 'python3' 'python3-pip' 'default-jdk' 'openvpn' 'software-properties-common' 'php'"

##PATHS AND FILES

DOWNLOADS_PATH="softwares"

#COLORS

RED='\e[1;91m'
GREEN='\e[1;92m'
NO_COLOR='\e[0m'


#functions

#Updating repository and doing system update

apt_update(){
  sudo apt update && sudo apt dist-upgrade -y
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

echo -e "${GREEN}[INFO] - Downloading packages .deb${NO_COLOR}"

mkdir "$DOWNLOADS_PATH"
wget -c "$URL_GOOGLE_CHROME" -P "$DOWNLOADS_PATH"

## Installing .deb packages downloaded in the previous session ##
echo -e "${GREEN}[INFO] - Installing downloaded .deb packages${NO_COLOR}"
sudo dpkg -i $DOWNLOADS_PATH/*.deb

# Install programs in apt #
echo -e "${GREEN}[INFO] - Installing apt packages from repository${NO_COLOR}"

for software_name in "${SOFTWARES_TO_INSTALL[@]}"; do
  if ! dpkg -l | grep -q $software_name; then # Only install if it is not already installed
    sudo apt install "$software_name" -y
  else
    echo "[INSTALLED] - $software_name"
  fi
done

}
## Installing Flatpak packages ##
install_flatpaks(){

  echo -e "${GREEN}[INFO] - Installing flatpak packages${NO_COLOR}"

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
