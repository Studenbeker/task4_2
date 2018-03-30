#!/bin/bash

ps auxw | grep ntpd | grep -v grep > /dev/null

if [ $? != 0 ];
then
echo "NOTICE: ntp is not running"
echo "NOTICE: ntp is not running" >> /var/mail/root
service ntp start
fi

diff /etc/ntp.conf /etc/ntp.conf.back-up > /dev/null
if [ $? == 1 ];
then
echo "NOTICE: /etc/ntp.conf was changed. Calculated diff:" >> /var/mail/root

diff -u0 /etc/ntp.conf.back-up /etc/ntp.conf >> /var/mail/root
echo "Restoring ntp.conf and restart ntp server"
cat /etc/ntp.conf.back-up > /etc/ntp.conf
service ntp restart > /dev/null
fi;
