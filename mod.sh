#!/bin/bash
set_environment(){
 	source env.sh
 	export MACHINE_OS=$(lsb_release -si)
  export MACHINE_ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
  export MACHINE_VER=$(lsb_release -sr)
}

update_server(){
	sudo apt-get update  >> "/tmp/script_log.txt"
}

run_module(){
 echo "OS version detected $MACHINE_OS  $MACHINE_VER"
 if [ -e "./modules/${MODULE}/#{$MACHINE_OS}/#{$MACHINE_VER}/main.sh" ]
	then
  	"${MODULE}/#{$MACHINE_OS}/#{$MACHINE_VER}/main.sh"
  else
  	./modules/${MODULE}/main.sh >> /tmp/script_log.txt
  fi
}

set_environment
update_server
for MODULE in $SCRIPT_MODULES
do
  echo "Running the module $MODULE"
  run_module
  if [ "$?" -ne "0" ]
  	then
  	echo "Could not run the module $MODULE"
  fi
done
