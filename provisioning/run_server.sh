#! /bin/bash

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

source env.sh
run_script_on_server
remove_scripts