#! /bin/bash

MYSQL=$(which mysql | wc -l)

if [ "$MYSQL" -ne "0" ]
  then
    echo "Mysql already installed"
  else
  	sudo apt-get -y --force-yes install mysql-server
fi