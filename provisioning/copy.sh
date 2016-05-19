#! /bin/bash

set_environment() {
	source env.sh
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


set_environment
run_command_on_server mkdir /tmp/pscript
copy_to_server