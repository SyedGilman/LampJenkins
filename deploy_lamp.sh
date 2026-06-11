#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

echo "Updating system packages..."
sudo apt-get update -y

echo "Installing Apache Web Server..."
sudo apt-get install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2

echo "Installing MySQL Server..."
sudo apt-get install mysql-server -y
sudo systemctl start mysql
sudo systemctl enable mysql

echo "Installing PHP and extensions..."
sudo apt-get install php libapache2-mod-php php-mysql -y

echo "Restarting Apache to load PHP..."
sudo systemctl restart apache2

echo "LAMP Stack Installation Complete!"
