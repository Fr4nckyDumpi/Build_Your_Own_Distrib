#!/bin/bash

apt-get install -y php-mysql && apt-get install -y debconf-utils

if ! which mysql &> /dev/null; then
    echo "Enter the root password you want on MySQL"
    read -p "Password : " pass
    read -p "Password Confirmation : " confpass
    
    if [ "$pass" == "$confpass" ]; then
        echo "mysql-server mysql-server/root_password password " | debconf-set-selections
        echo "mysql-server mysql-server/root_password_again password " | debconf-set-selections
        apt-get install -y mysql-server;
        service mysql start
        mysql -e "UPDATE mysql.user SET Password = PASSWORD('${pass}') WHERE User = 'root'"
        mysql -e "FLUSH PRIVILEGES"
        service mysql restart
    else
        echo -e "\e[31m ERROR:\e[0m verify password does not match."
    fi    
fi