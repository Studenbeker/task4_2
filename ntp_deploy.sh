#!/bin/bash
dirsc=$(dirname $0)
Installed=$(dpkg -l ntp | grep ii |wc -l)
if [ $Installed = 0 ]
then

apt update

#Install ntp on the server
echo "Installing ntp"
apt install ntp -y -q
fi


#The config files for ntp lies in /etc/ntp.conf.
sed -i '/.ubuntu.pool.ntp.org/d' /etc/ntp.conf
sed -i '/ua.pool.ntp.org/d' /etc/ntp.conf
sed -i "18i pool ua.pool.ntp.org iburst" /etc/ntp.conf

echo "Creating bak"
cat /etc/ntp.conf >> /etc/ntp.conf.back-up

#Restart the service.
systemctl restart ntp

cron="*/1 * * * * $dirsc/ntp_verify.sh"
(crontab -l 2>/dev/null | grep -v -F "$cron" ; echo "$cron") | crontab -
