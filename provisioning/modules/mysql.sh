#! /bin/bash
if [ -e "/etc/init.d/mysql" ]
  then
    echo "Mysql already installed"
  else
  	sudo apt-get install mysql-server
fi