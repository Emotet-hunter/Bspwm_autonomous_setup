#!/bin/bash

cd ~/Downloads

chmod +x NVIDIA*.run

sudo ./NVIDIA*.run

systemctl set-default graphical.target

reboot
