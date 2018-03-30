#!/bin/bash

#Install ntp on the server
sudo apt-get install -y ntp > /dev/null

#The config files for ntp lies in /etc/ntp.conf.

sed -i "s/0.ubuntu.pool.ntp.org/ua.pool.ntp.org/g" /etc/ntp.conf
sed -i "/pool 1.ubuntu.pool.ntp.org iburst/d" /etc/ntp.conf
sed -i "/pool 2.ubuntu.pool.ntp.org iburst/d" /etc/ntp.conf
sed -i "/pool 3.ubuntu.pool.ntp.org iburst/d" /etc/ntp.conf

#Restart the service.

service ntp restart

cp /etc/ntp.conf /etc/ntp.conf.back-up

cron="*/1 * * * * `pwd`/ntp_verify.sh"
(crontab -l 2>/dev/null | grep -v -F "$cron" ; echo "$cron") | crontab -
