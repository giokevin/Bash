#!/bin/bash

status=0
while [ 1 ] ;do
    nc -zw 2 google.com 80
    ret="$?"
    echo "$ret, status: $status"
    if [ "$ret" = 0 -a "$status" = 0 ] ;then
	ip=$(curl -s https://api.ipify.org)
	date=$(date) 
        thepathtoyourtelegramcli -k thepathtoyourtg-server.pub -W -e "msg thereceiveruser the server is connected to internet with the ip address: $ip, on date: $date"
        status=1

    elif [ "$ret" -ne 0 -a "$status" = 1 ] ;then
	date=$(date)
        thepathtoyourtelegramcli -k thepathtoyourtg-server.pub -W -e "msg thereceiveruser the server is disconnected on date: $date"
        status=0 ;fi

    sleep 10 ;done
