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

echo -e "#\!/bin/sh \nbright=\$(<\"/sys/class/backlight/intel_backlight/brightness\") \nif ((\$bright >= 1100)) \nthen \n    expr \$bright - 1000 > /sys/class/backlight/intel_backlight/brightness \nfi" > /usr/local/bin/reducebright

echo -e "#\!/bin/sh \nbright=\$(<\"/sys/class/backlight/intel_backlight/brightness\") \nif ((\$bright <= 25666)) \nthen \n    expr \$bright + 1000 > /sys/class/backlight/intel_backlight/brightness \nfi" > /usr/local/bin/increasebright

echo -e "#\!/bin/sh \nchown <LOCALUSER> /sys/class/backlight/intel_backlight/brightness" > /usr/local/bin/brightome

chown <LOCALUSER> /usr/local/bin/increasebright

chown <LOCALUSER> /usr/local/bin/reducebright

chown <LOCALUSER> /usr/local/bin/brightome

chmod u+x /usr/local/bin/increasebright

chmod u+x /usr/local/bin/reducebright

chmod u+x /usr/local/bin/brightome

#Now you can type ./reducebright or ./increasebright to edit bright level

#Assign to key combination

apt-get install xbindkeys xbindkeys-config -y

cp -r .xbindkeysrc /home/<LOCALUSER>/

xbindkeys --defaults > /home/<LOCALUSER>/.xbindkeysrc

killall -s1 xbindkeys

xbindkeys -f /home/<LOCALUSER>/.xbindkeysrc

#Now Ctr+"+" to increase bright and Crt+"-" to reduce bright



#################################################
############## MATE CONFIGURATION ###############
#################################################

#Move image to backgrounds
mv wallpaper.jpg /usr/share/backgrounds/

su <LOCALUSER>

#Set the new wallpaper
gsettings set org.mate.background picture-filename /usr/share/backgrounds/wallpaper.jpg
#Set acurate style
gsettings set org.mate.background picture-options zoom

# Set the visibility of some icons on your Desktop
gsettings set org.mate.caja.desktop home-icon-visible false
gsettings set org.mate.caja.desktop volumes-visible false

# Set the date format of files in Caja to yyyy-MM-dd hh:mm:ss
gsettings set org.mate.caja.preferences date-format "iso"

# Tell Caja to use detailed lists by default
gsettings set org.mate.caja.preferences default-folder-viewer 'list-view'

# Enable the Delete command in Caja
gsettings set org.mate.caja.preferences enable-delete true

# Disable sound preview
#gsettings set org.mate.caja.preferences preview-sound 'never'

# Show hidden files in Caja
gsettings set org.mate.caja.preferences show-hidden-files true

# Disable window animation effects
#gsettings set org.mate.interface enable-animations false

# Set the order and position of window controls
#gsettings set org.mate.interface gtk-decoration-layout "menu:minimize,maximize,close"

# Hide input-related menus
#gsettings set org.mate.interface show-input-method-menu false
#gsettings set org.mate.interface show-unicode-menu false

# Set toolbars to display icons with text below
gsettings set org.mate.interface toolbar-style both

# Disable keyboard sounds
gsettings set org.mate.Marco.general audible-bell false

# Set the order and position of window controls
#gsettings set org.mate.Marco.general button-layout "menu:minimize,maximize,close"

# Center new windows on screen
gsettings set org.mate.Marco.general center-new-windows true

# Maximise new windows (except the ones listed below)
#gsettings set org.mate.maximus exclude-class "['mate-terminal', 'galculator']"
#gsettings set org.mate.maximus no-maximize false

# Keep maximised windows decorated
#gsettings set org.mate.maximus undecorate false

# Disallow autorun on media insertion
gsettings set org.mate.media-handling autorun-never true
gsettings set org.mate.media-handling automount-open false

# Show this number of items in the places menu
gsettings set org.mate.panel.menubar max-items-or-submenu 10

# Always show notifications on the specified monitor
#gsettings set org.mate.NotificationDaemon theme "coco"
#gsettings set org.mate.NotificationDaemon monitor-number 1
#gsettings set org.mate.NotificationDaemon use-active-monitor false

# Set Pluma's colours to classic
gsettings set org.mate.pluma color-scheme "classic"

# Disable right margin in Pluma
gsettings set org.mate.pluma display-right-margin false

# Tell Pluma to convert tabs to spaces
#gsettings set org.mate.pluma insert-spaces true

# Disable wrapping in Pluma
#gsettings set org.mate.pluma wrap-mode GTK_WRAP_NONE

# Some power management
gsettings set org.mate.power-manager action-critical-battery "suspend"

# Disable the suspend button
#gsettings set org.mate.power-manager button-suspend "nothing"

# Always show power icon
#gsettings set org.mate.power-manager icon-policy "always"

# Turn off monitors after specified number of seconds
#gsettings set org.mate.power-manager sleep-display-ac 3600

# Disable screensaver
#gsettings set org.mate.screensaver mode "blank-only"

# Disallow user switching when screen is locked
#gsettings set org.mate.screensaver user-switch-enabled false

# Activate power saving after a certain number of minutes
#gsettings set org.mate.session idle-delay 60

# Disable keyboard sounds
#gsettings set org.mate.sound input-feedback-sounds false

