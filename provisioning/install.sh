#! /bin/bash

#install RVM

install_rvm(){
  echo "Downloading RVM"
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  \curl -sSL https://get.rvm.io | bash -s stable
  echo "Setting RVM path"
 source ~/.rvm/scripts/rvm
}

check_status(){
  if [ "$1" -ne 0 ]
  then
  echo "Exiting with code $2"
  fi
}

set_environment(){
source env.sh
}

install_ruby(){

RUBY=$(which ruby | wc -l)
if [ "$RUBY" -ne "0" ]
  then
  INSTALLED_RUBY_VERSION=$(ruby --version)
  echo "Ruby already installed $INSTALLED_RUBY_VERSION"
  echo "Installing again ruby $INSTALLED_RUBY_VERSION"
fi
rvm install $SCRIPT_RUBY_VERSION
}

echo "Installing RVM:"

if [ -e ~/.rvm/scripts/rvm ]
then
  echo "RVM already exists"
  source ~/.rvm/scripts/rvm
else
  install_rvm
  check_status $? 2
fi

set_environment

install_ruby

