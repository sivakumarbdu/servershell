#!/bin/bash
set_environment(){
 	source env.sh
}

set_environment
for MODULE in $SCRIPT_MODULES
do
  echo "Running the module $MODULE"
  "./modules/${MODULE}.sh"
  if [ "$?" -ne "0" ]
  	then
  	echo "Could not run the module $MODULE"
  fi
done