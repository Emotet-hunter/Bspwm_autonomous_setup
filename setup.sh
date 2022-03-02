#!/bin/bash

########################################
########### MISSING STEPS ##############
########################################

#Configure Terminal Default profile (Hack Nerd Font included)
#Change Pluma theme to Cobalt
#Install last Firefox version and locate un /opt/
#Install Foxy Proxy Addon
#Install Wappalizer Addon

repo=$(pwd)


########################################
########### UPDATE SYSTEM ##############
########################################

apt update

parrot-upgrade

########################################
######### INSTALL LIBRARIES ############
########################################


apt install build-essential git vim vim-gtk xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev -y


cd /home/<LOCALUSER>/Downloads

#Install github-desktop

sudo wget https://github.com/shiftkey/desktop/releases/download/release-2.9.3-linux3/GitHubDesktop-linux-2.9.3-linux3.deb

sudo gdebi GitHubDesktop-linux-2.9.3-linux3.deb -y

#Clone bspwm repository

git clone https://github.com/baskerville/bspwm.git

#Clone sxhkd repository

git clone https://github.com/baskerville/sxhkd.git

#Compile bspwm

cd bspwm

make

sudo make install

#Compile sxhkd

cd ../sxhkd

make

sudo make install

sudo apt install bspwm -y

#Loading example config files

mkdir /home/<LOCALUSER>/.config/bspwm

chown <LOCALUSER> /home/<LOCALUSER>/.config/bspwm

chgrp <LOCALUSER> /home/<LOCALUSER>/.config/bspwm

mkdir /home/<LOCALUSER>/.config/sxhkd

chown <LOCALUSER> /home/<LOCALUSER>/.config/sxhkd

chgrp <LOCALUSER> /home/<LOCALUSER>/.config/sxhkd

#bspwm

#Load Final bspwm configuration file

cp /home/<LOCALUSER>/Downloads/bspwm/examples/bspwmrc /home/<LOCALUSER>/.config/bspwm/

chown <LOCALUSER> /home/<LOCALUSER>/.config/bspwm/bspwmrc

chgrp <LOCALUSER> /home/<LOCALUSER>/.config/bspwm/bspwmrc

chmod +x /home/<LOCALUSER>/.config/bspwm/bspwmrc

#sxhkd

#Resize file

mkdir /home/<LOCALUSER>/.config/bspwm/scripts

chown <LOCALUSER> /home/<LOCALUSER>/.config/bspwm/scripts

chgrp <LOCALUSER> /home/<LOCALUSER>/.config/bspwm/scripts

touch /home/<LOCALUSER>/.config/bspwm/scripts/bspwm_resize

echo -e '#!'"/usr/bin/env dash\n\nif bspc query -N -n focused.floating > /dev/null; then\n    step=20\nelse\n    step=100\nfi\n\ncase \"\$1\" in\n    west) dir=right; falldir=left; x=\"-\$step\"; y=0;;\n    east) dir=right; falldir=left; x=\"\$step\"; y=0;;\n    north) dir=top; falldir=bottom; x=0; y=\"-\$step\";;\n    south) dir=top; falldir=bottom; x=0; y=\"\$step\";;\nesac\n\nbspc node -z \"\$dir\" \"\$x\" \"\$y\" || bspc node -z \"\$falldir\" \"\$x\" \"\$y\"" > /home/<LOCALUSER>/.config/bspwm/scripts/bspwm_resize

chown <LOCALUSER> /home/<LOCALUSER>/.config/bspwm/scripts/bspwm_resize

chgrp <LOCALUSER> /home/<LOCALUSER>/.config/bspwm/scripts/bspwm_resize

chmod +x /home/<LOCALUSER>/.config/bspwm/scripts/bspwm_resize



#Load Final sxhkd configuration file

cp $repo/sxhkd/sxhkdrc /home/<LOCALUSER>/.config/sxhkd/

chown <LOCALUSER> /home/<LOCALUSER>/.config/sxhkd/sxhkdrc

chgrp <LOCALUSER> /home/<LOCALUSER>/.config/sxhkd/sxhkdrc

chmod +x /home/<LOCALUSER>/.config/sxhkd/sxhkdrc

#Add previous script path to sxhkdrc

echo "    /home/<LOCALUSER>/.config/bspwm/scripts/bspwm_resize {west,south,north,east}" >> /home/<LOCALUSER>/.config/sxhkd/sxhkdrc


#Polybar isntall

sudo apt install cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev libuv1-dev -y

cd /home/<LOCALUSER>/Downloads

git clone --recursive https://github.com/polybar/polybar

cd polybar/

mkdir build

cd build/

cmake ..

make -j$(nproc)

sudo make install

#Picom install

sudo apt install meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev -y

cd /home/<LOCALUSER>/Downloads

git clone https://github.com/ibhagwan/picom.git

cd picom/

git submodule update --init --recursive

meson --buildtype=release . build

ninja -C build

sudo ninja -C build install

#Rofi install

sudo apt install rofi -y

#Install firefox

chown <LOCALUSER>:<LOCALUSER> /opt/

cd /opt

#Firejail

sudo apt install firejail -y

#Hack Nerd Fonts

chown <LOCALUSER>:<LOCALUSER> /usr/local/share/fonts/

cd /usr/local/share/fonts

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip

unzip Hack.zip

rm Hack.zip

#Feh

sudo apt install feh -y

mv $repo/images/wallpaper.jpg /usr/share/backgrounds/

echo 'feh --bg-fill /usr/share/backgrounds/wallpaper.jpg' >> /home/<LOCALUSER>/.config/bspwm/bspwmrc

#Polybar Lib

cd /home/<LOCALUSER>/Downloads

git clone https://github.com/VaughnValle/blue-sky.git

cp /home/<LOCALUSER>/Downloads/blue-sky/polybar/* -r /home/<LOCALUSER>/.config/polybar/

echo '/home/<LOCALUSER>/.config/polybar/./launch.sh' >> /home/<LOCALUSER>/.config/bspwm/bspwmrc 

cp /home/<LOCALUSER>/.config/polybar/fonts/* -r /usr/share/fonts/truetype/

fc-cache -v

#Picom Lib

mkdir /home/<LOCALUSER>/.config/picom

chown <LOCALUSER>:<LOCALUSER> /home/<LOCALUSER>/.config/picom

cp /home/<LOCALUSER>/Downloads/blue-sky/picom.conf /home/<LOCALUSER>/.config/picom/

#Editar

#Mouse Follow
echo -e "bspc config focus_follows_pointer true" >> /home/<LOCALUSER>/.config/bspwm/bspwmrc

#Rounded Corners
echo -e "picom --experimental-backends &" >> /home/<LOCALUSER>/.config/bspwm/bspwmrc
echo -e "bspc config border_width 0" >> /home/<LOCALUSER>/.config/bspwm/bspwmrc

#Opacity Rule
echo -e "opacity-rule = [\n    \"100:class_g='Rofi'\"\n];" >> /home/<LOCALUSER>/.config/picom/picom.conf

#Ethernet polybar module

mkdir /home/<LOCALUSER>/.config/bin

chown <LOCALUSER>:<LOCALUSER> /home/<LOCALUSER>/.config/bin

cp $repo/polybar/modules/ethernet_status.sh /home/<LOCALUSER>/.config/bin/

#include module in polybar

#Hack the Box polybar module

cp $repo/hackthebox_status.sh /home/<LOCALUSER>/.config/bin/

#include module in polybar

#Configure sysmenu module proportions in $HOME/.config/polybar/scripts/themes/powermenu_alt.rasi

#Rofi Nord theme
mkdir /home/<LOCALUSER>/.config/rofi

chown <LOCALUSER>:<LOCALUSER> /home/<LOCALUSER>/.config/rofi

mkdir /home/<LOCALUSER>/.config/rofi/themes

chown <LOCALUSER>:<LOCALUSER> /home/<LOCALUSER>/.config/rofi/themes

cp /home/<LOCALUSER>/Downloads/blue-sky/nord.rasi /home/<LOCALUSER>/.config/rofi/themes

#rofi-theme-selector and alt+a to set theme

#Slim and Slimlock install

sudo apt install slim libpam0g-dev libxrandr-dev libfreetype6-dev libimlib2-dev libxft-dev -y

cd /home/<LOCALUSER>/Downloads

git clone https://github.com/joelburget/slimlock.git

cd slimlock/

sudo make

sudo make install

cd /home/<LOCALUSER>/Downloads/blue-sky/slim

sudo cp slim.conf /etc/

sudo cp slimlock.conf /etc/

sudo cp -r default /usr/share/slim/themes/

#Config Slimlock

rm /usr/share/slim/themes/background.png

rm /usr/share/slim/themes/panel.png

cp $repo/background.png /usr/share/slim/themes/

cp $repo/panel.png /usr/share/slim/themes/

#Fix cursor

echo -e "xsetroot -cursor_name left_ptr &" >> /home/<LOCALUSER>/.config/bspwm/bspwmrc




