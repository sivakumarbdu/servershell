#! /bin/bash
echo "Module Postgresql"
if [ -e "/etc/init.d/postgresql" ]
  then
  echo "Postgresql already installed"
else
  sudo apt-get -y install  postgresql postgresql-contrib
fi