#!/bin/bash

if [ "$EUID" -ne 0 ]
  then 
	echo -e "\e[31mPlease run as root\e[0m"
  exit
fi

while [ "$1" != "" ]; do
   PARAM=`echo $1 | awk -F= '{print $1}'`
   case $PARAM in
      -h | --help)
         echo "Usage: ./install.sh"
         exit
         ;;
  	   *)
         echo -e "\e[31m ERROR:\e[0m unknown parameter \"$PARAM\""
	      echo ""
         echo "Usage: ./install.sh"
         exit
      ;;
   esac
   shift
done

verifsecurity()
{
   echo -e "\e[32m Iptables :\e[0m"
   iptables --version
}

veriftools()
{
   echo -e "\e[32m Emacs :\e[0m"
   emacs --version
}

verifweb() 
{
   echo -e "\e[32m PHP :\e[0m"
   php -v
   echo -e "\e[32m Apache :\e[0m"
   apache2 -v
   echo -e "\e[32m Mysql :\e[0m"
   mysql --version 
}

startsecurity()
{
   bash security/iptables.sh
}

starttools()
{
   bash tools/update.sh
   bash tools/emacs.sh
}

startweb()
{
   bash web/apache.sh
   bash web/php.sh
   bash web/mysql.sh
}

startoulall()
{
   startsecurity
   starttools
   startweb
}

while [ "$0" ]; do
   echo "Found 3 folders:"
   echo -e "\e[32m1\e[0m - security"
   echo -e "\e[32m2\e[0m - tools"
   echo -e "\e[32m3\e[0m - web"
   echo -e "\e[32mq\e[0m - exit"
   echo "Enter (1 - 3) [Default All]:"
   read nbr
   case $nbr in
      1)
         echo -e "\e[32mSecurity Selected\e[0m"
         startsecurity
         ;;
      2)
         echo -e "\e[32mTools Selected\e[0m"
         starttools
         veriftools
         ;;
      3)
         echo -e "\e[32mWeb Selected\e[0m"
         startweb
         verifweb
         ;;
      '')
         echo -e "\e[32mAll Selected\e[0m"
         startoulall
         ;;
      q)
         echo -e "\e[32mYou leave the program properly.\e[0m"
         exit
         ;;
   esac
   shift 
done