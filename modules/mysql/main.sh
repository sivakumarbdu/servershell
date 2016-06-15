#! /bin/bash

MYSQL_LEN = $(which mysql | wc -l)
if [ "$MYSQL_LEN" -ne "0" ]
  then
    echo "Mysql already installed"
  else
  	sudo apt-get -y --force-yes install mysql-server
fi