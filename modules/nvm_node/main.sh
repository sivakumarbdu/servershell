#! /bin/bash
echo "installing NVM (Node Version Manager)"
if [ -e "~/.nvm/nvm.sh" ]
	then
	echo "NVM already installed"
else
	wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | bash
	source ~/.nvm/nvm.sh
	if [ "$?" -eq "0" ]
	  then
	    echo "Node Version Manager (NVM) installed"
	   else
	   	echo "Could not install NVM. exit with status $?"
	fi
fi

echo "installing node"

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