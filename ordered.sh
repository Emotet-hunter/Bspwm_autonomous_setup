#!/bin/bash

#Change aparience
bash ./mate_config.sh

#Bright Driver Setup
sudo bash ./drivers/bright_drivers_setup.sh

#Nvidia Driver
bash ./drivers/nvidia_setup_0.sh
bash ./drivers/nvidia_setup_1.sh

#Pro setup
sudo bash ./setup.sh

