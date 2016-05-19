#! /bin/bash
echo "Module Postgresql"
if [ -e "/etc/init.d/postgresql" ]
  then
  echo "Postgresql already installed"
else
  sudo apt-get install postgresql postgresql-contrib
  echo "setting password"
  sudo -u postgres psql postgres
  \password postgres
fi