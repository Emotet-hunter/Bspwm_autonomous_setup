#!/bin/bash

########################################
########### MISSING STEPS ##############
########################################

#Configure Terminal Default profile (Hack Nerd Font included)
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

sudo gdebi GitHubDesktop-linux-2.9.3-linux3.deb

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

mkdir /home/<LOCALUSER>/.config/sxhkd/scripts

chown <LOCALUSER> /home/<LOCALUSER>/.config/sxhkd/scripts

chgrp <LOCALUSER> /home/<LOCALUSER>/.config/sxhkd/scripts

touch /home/<LOCALUSER>/.config/sxhkd/scripts/bspwm_resize

echo -e "#!/usr/bin/env dash\n\nif bspc query -N -n focused.floating > /dev/null; then\n    step=20\nelse\n    step=100\nfi\n\ncase \"\$1\" in\n    west) dir=right; falldir=left; x=\"-\$step\"; y=0;;\n    east) dir=right; falldir=left; x=\"\$step\"; y=0;;\n    north) dir=top; falldir=bottom; x=0; y=\"-\$step\";;\n    south) dir=top; falldir=bottom; x=0; y=\"\$step\";;\nesac\n\nbspc node -z \"\$dir\" \"\$x\" \"\$y\" || bspc node -z \"\$falldir\" \"\$x\" \"\$y\"" > /home/<LOCALUSER>/.config/bspwm/scripts/bspwm_resize

chown <LOCALUSER> /home/<LOCALUSER>/.config/sxhkd/scripts/bspwm_resize

chgrp <LOCALUSER> /home/<LOCALUSER>/.config/sxhkd/scripts/bspwm_resize

chmod +x /home/<LOCALUSER>/.config/sxhkd/scripts/bspwm_resize



#Load Final sxhkd configuration file

touch /home/<LOCALUSER>/.config/sxhkd/sxhkdrc

echo -e "#
# wm independent hotkeys
#
 
# terminal emulator
super + Return
    gnome-terminal
 
# rofi
super + space
    rofi -show run
    
# firefox
super + shift + f
    firejail /opt/firefox/firefox
 
# make sxhkd reload its configuration files:
super + Escape
    pkill -USR1 -x sxhkd
 
#
# bspwm hotkeys
#
 
# quit/restart bspwm
super + alt + {q,r}
    bspc {quit,wm -r}
 
# close and kill
super + {_,shift + }w
    bspc node -{c,k}
 
# alternate between the tiled and monocle layout
super + m
    bspc desktop -l next
 
# send the newest marked node to the newest preselected node
super + y
    bspc node newest.marked.local -n newest.!automatic.local
 
# swap the current node and the biggest node
super + g
    bspc node -s biggest
 
#
# state/flags
#
 
# set the window state
super + {t,shift + t,s,f}
    bspc node -t {tiled,pseudo_tiled,floating,fullscreen}
 
# set the node flags
super + ctrl + {m,x,y,z}
    bspc node -g {marked,locked,sticky,private}
 
#
# focus/swap
#
 
super + {_,shift + }{Left,Down,Up,Right}
       bspc node -{f,s} {west,south,north,east}
 
 
# focus the node for the given path jump
super + {p,b,comma,period}
    bspc node -f @{parent,brother,first,second}
 
# focus the next/previous node in the current desktop
super + {_,shift + }c
    bspc node -f {next,prev}.local
 
# focus the next/previous desktop in the current monitor
super + bracket{left,right}
    bspc desktop -f {prev,next}.local
 
# focus the last node/desktop
super + {grave,Tab}
    bspc {node,desktop} -f last
 
# focus the older or newer node in the focus history
super + {o,i}
    bspc wm -h off; \
    bspc node {older,newer} -f; \
    bspc wm -h on
 
# focus or send to the given desktop
super + {_,shift + }{1-9,0}
    bspc {desktop -f,node -d} '^{1-9,10}'
 
#
# preselect
#
 
# preselect the direction
super + ctrl + alt + {Left,Down,Up,Right}
    bspc node -p {west,south,north,east}
 
 
# preselect the ratio
super + ctrl + {1-9}
    bspc node -o 0.{1-9}
 
# cancel the preselection for the focused node
super + ctrl + space
    bspc node -p cancel
 
# cancel the preselection for the focused desktop
super + ctrl + alt + space
    bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel
 
#
# move/resize
#
 
# expand a window by moving one of its side outward
#super + alt + {h,j,k,l}
#   bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}
 
# contract a window by moving one of its side inward
#super + alt + shift + {h,j,k,l}
#   bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}
 
# move a floating window
super + ctrl + {Left,Down,Up,Right}
    bspc node -v {-20 0,0 20,0 -20,20 0}
 
# Custom move/resize
alt + super + {Left,Down,Up,Right}
    /home/<LOCALUSER>/.config/bspwm/scripts/bspwm_resize {west,south,north,east}" > /home/<LOCALUSER>/.config/sxhkd/sxhkdrc

chown <LOCALUSER> /home/<LOCALUSER>/.config/sxhkd/sxhkdrc

chgrp <LOCALUSER> /home/<LOCALUSER>/.config/sxhkd/sxhkdrc

chmod +x /home/<LOCALUSER>/.config/sxhkd/sxhkdrc


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

kill -9 -1

#Install firefox

chown <LOCALUSER>:<LOCALUSER> /opt/

cd /opt

#Download firefox installer
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1WSczvDnpNia8HiZg4sPdqaGYmfHKPAP3' -O firefox-97.0.tar.bz2

tar -xf firefox-97.0.tar.bz2

rm firefox-97.0.tar.bz2

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

mv $repo/wallpaper.jpg /usr/share/backgrounds/

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

cp $repo/ethernet_status.sh /home/<LOCALUSER>/.config/bin/

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




