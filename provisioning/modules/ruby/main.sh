#! /bin/bash

echo "Module Ruby"
install_ruby(){

RUBY=$(which ruby | wc -l)
if [ "$RUBY" -ne "0" ]
  then
  INSTALLED_RUBY_VERSION=$(ruby --version)
  echo "Ruby already installed $INSTALLED_RUBY_VERSION"
  echo "Reinstalling ruby $INSTALLED_RUBY_VERSION"
   ~/.rvm/bin/rvm reinstall $SCRIPT_RUBY_VERSION
else
   ~/.rvm/bin/rvm install $SCRIPT_RUBY_VERSION
fi
}

install_ruby