#!/usr/bin


# @Author Frances Ruganyumisa 
# for Final Year Project Works
# MIT License applies for this file

cd nagioscore-nagios-4.4.5

sudo apt update

echo "***Installing dependencies for nagios tool"


sudo apt-get install -y autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php7.2 libgd-dev

echo "***Configuring  the system and development fo the Makefile"

sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled

echo "***Installing nagios system"
sudo make all

echo "***creating user and group"
sudo make install-groups-users
sudo usermod -a -G nagios www-data

echo "***Installing the binaries"
sudo make install

echo "***Installing the service/Daemon"
sudo make install-Daemoninit

echo "***Installing configurations files"
sudo make install-config

echo "***Installing apache config files"
sudo make install-webconf
sudo a2enmod rewrite
sudo a2enmod cgi

echo "***Configuring FIrewall to allow to access nagios via web interface"
sudo ufw allow Apache
sudo ufw reload

echo "***Creating admin user for nagios.."
udo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

echo "***If you are here congratulations, you have successfully installed nagios for fyp"

echo "starting apache server"
sudo systemctl restart apache2.service

echo "Starting the nagios service"
sudo systemctl start nagios.service
