#! /bin/bash
echo "Run module git"
GIT_LEN=$(which git | wc -l)
if [ "$GIT_LEN" -ne "0" ]
	then
	echo "Git already installed"
else
	echo "installing git"
	sudo apt-get -y install git
fi