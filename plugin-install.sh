#!/bin/sh

#Author @Frances Ruganyumisa
#For Final Year project bash script to install dependencies to install nagios plugins


echo "This script installs necessary dependencies to run nagios plugins"

cd net-snmp-5.8/

echo "Configuring environment to install snmp utils follow the prompts"
./configure --with-perl-modules --enable-embedded-perl --enable-shared
make test
sudo make install

echo "Congratulations if all the dependencies matched"

cd ..
cd fping-4.2/
./configure
make
sudo make install
cd ..

#git clone https://github.com/networkupstools/nut.git

sudo apt install nut-server

git clone https://git.openldap.org/openldap/openldap.git
cd openldap/
./configure
make depend
make
sudo make install
cd ..

# Create the file repository configuration:
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Import the repository signing key:
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Update the package lists:
sudo apt-get update

# Install the latest version of PostgreSQL.
# If you want a specific version, use 'postgresql-12' or similar instead of 'postgresql':
sudo apt-get install postgresql