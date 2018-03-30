#!/bin/bash
#ntp_verify.sh

ps auxw | grep ntpd | grep -v grep > /dev/null

if [ $? != 0 ];
then
echo "ntp is not running."

service ntp start
fi

diff /etc/ntp.conf /etc/ntp.conf.back-up > /dev/null
if [ $? == 1 ]; then
# they're different!
echo "ntp.conf was changed."
diff -u0 /etc/ntp.conf.back-up /etc/ntp.conf
echo "Restoring ntp.conf and restart ntp server"
cat /etc/ntp.conf.back-up > /etc/ntp.conf
service ntp restart > /dev/null
fi;
