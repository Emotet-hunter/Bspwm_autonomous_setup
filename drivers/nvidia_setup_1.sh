#!/bin/bash

cd ~/Downloads

chmod +x NVIDIA*.run

./NVIDIA*.run

systemctl set-default graphical.target

reboot
