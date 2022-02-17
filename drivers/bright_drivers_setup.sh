#!/bin/bash

#################################################
############## UPDATE REPOSITORIES ##############
#################################################

apt update

parrot-upgrade

#################################################
################ Bright Drivers #################
#################################################

#Create Drivers
#In this case we are going to create the drivers in /usr/local/bin because this path is included in $PATH, in case was not included, include this path or change the location of the scripts

chown <LOCALUSER> /sys/class/backlight/intel_backlight/brightness

echo -e '#!'"/bin/bash \nbright=\$(<\"/sys/class/backlight/intel_backlight/brightness\") \nif ((\$bright >= 1100)) \nthen \n    expr \$bright - 1000 > /sys/class/backlight/intel_backlight/brightness \nfi" > /usr/local/bin/reducebright

echo -e '#!'"/bin/bash \nbright=\$(<\"/sys/class/backlight/intel_backlight/brightness\") \nif ((\$bright <= 25666)) \nthen \n    expr \$bright + 1000 > /sys/class/backlight/intel_backlight/brightness \nfi" > /usr/local/bin/increasebright

echo -e '#!'"/bin/bash \nchown <LOCALUSER> /sys/class/backlight/intel_backlight/brightness" > /usr/local/bin/brightome

chown <LOCALUSER> /usr/local/bin/increasebright

chown <LOCALUSER> /usr/local/bin/reducebright

chown <LOCALUSER> /usr/local/bin/brightome

chmod u+x /usr/local/bin/increasebright

chmod u+x /usr/local/bin/reducebright

chmod u+x /usr/local/bin/brightome

#Now you can type ./reducebright or ./increasebright to edit bright level

#Assignation in sxhkdrc to Ctrl + '+' and Ctrl + '-'
