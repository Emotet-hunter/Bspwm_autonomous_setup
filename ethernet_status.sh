#!/bin/bash

ip_add=$(/usr/sbin/ifconfig eth0 | grep "inet " | awk '{print $2}')

if [[ -z $ip_add ]]; then
	ip_add=$(/usr/sbin/ifconfig wlan0 | grep "inet " | awk '{print $2}')
	echo "%{F#0cc919} %{F#ffffff}${ip_add}%{u-}"
else
	echo "%{F#2495e7} %{F#ffffff}${ip_add}%{u-}"

fi
