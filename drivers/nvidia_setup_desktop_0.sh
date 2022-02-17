#!/bin/bash

#Downloan nvidia driver

cd ~/Downloads/

sudo apt install nvidia-smi -y

wget https://es.download.nvidia.com/XFree86/Linux-x86_64/510.54/NVIDIA-Linux-x86_64-510.54.run

#drop to Runlevel3

systemctl set-default multi-user.target

sudo echo -e "nouveau blacklist\noptions nouveau modeset=0\nalias nouveau off" > /etc/modprobe.d/blacklist-nouveau.conf

update-initramfs -u 

reboot
