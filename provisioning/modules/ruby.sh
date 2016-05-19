#! /bin/bash

echo "Module Ruby"
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
install_ruby