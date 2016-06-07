#Selecting modules to install
Edit the env.sh and add the modules to install. You can check the modules insider modules/ folder.

export SCRIPT_MODULES="rvm_ruby nvm node mysql"

This will install ruby with rvm , node with nvm (node version manager) and mysql

#Privisioning local machine
``` ./run local ```
This will install modules in local machine

#Provisioning server

Conigure servers inside servers/ folder.  Create file with.sh(eg srever1.sh) extension add server details.

export PEM_FILE=""

export USER=""

export IP=""

PEM_FILE -> Location of .pem file (absolute path)

USER -> User name of the server

IP -> IP address of the server

This will install modules in server machine machine

``` ./run server ```
