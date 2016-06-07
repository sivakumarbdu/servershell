#! /bin/bash

echo "Node module"

set_environment(){
  source ~/.nvm/nvm.sh
}

install_node(){
  nvm install $SCRIPT_NODE_VERSION
}

NODE=$(which node | wc -l)
set_environment
if [ "$NODE" -eq "0" ]
	then
	install_node
else
	INSTALLED_NODE_VERSION=$(node --version)
	echo "Node already installed $INSTALLED_NODE_VERSION"
	install_node
fi