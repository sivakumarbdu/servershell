#! /bin/bash

set_environment() {
	source env.sh
}


run_script_on_server() {

ssh  -i $PEM_FILE ${USER}@${IP} << 'SCRIPT'
  cd /tmp/pscript;
  ./mod.sh
SCRIPT
}

remove_scripts() {
  ssh  -i $PEM_FILE ${USER}@${IP} << 'SCRIPT'
  rm -r /tmp/pscript
SCRIPT
}

run_command_on_server() {

ssh  -i $PEM_FILE ${USER}@${IP} << 'SCRIPT'
  cd /tmp/pscript;
  mkdir /tmp/pscript;
SCRIPT
}

copy_to_server(){
  scp  -i $PEM_FILE  -r * ${USER}@${IP}:/tmp/pscript
}


#copy files
set_environment
run_command_on_server mkdir /tmp/pscript
copy_to_server

#run script
run_script_on_server
remove_scripts