#! /bin/bash
echo "NVM module"
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