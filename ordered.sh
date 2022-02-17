#!/bin/bash

#Change aparience
bash ./mate_config.sh

#Bright Driver Setup
#Rewirte <LOCALUSER> 
sudo bash ./drivers/bright_drivers_setup.sh

#Nvidia Driver
#bash ./drivers/nvidia_setup_laptop_0.sh
#bash ./drivers/nvidia_setup_laptop_1.sh

#OR

bash ./drivers/nvidia_setup_desktop_0.sh
bash ./drivers/nvidia_setup_desktop_1.sh

#Pro setup
#Rewrite <LOCALUSER>
sudo bash ./setup.sh

