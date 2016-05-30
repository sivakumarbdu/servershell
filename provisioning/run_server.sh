#! /bin/bash

set_environment() {
	source env.sh
	source "servers/$1"
}


run_script_on_server() {

ssh  -i $PEM_FILE ${USER}@${IP} << 'SCRIPT'
  cd /tmp/pscript;
  ./mod.sh
SCRIPT
}

run_script_in_local() {
	./mod.sh
}


remove_scripts() {
  ssh  -i $PEM_FILE ${USER}@${IP} << 'SCRIPT'
  rm -r /tmp/pscript
SCRIPT
}

run_command_on_server() {
echo "run command on server"
ssh  -i $PEM_FILE ${USER}@${IP} << 'SCRIPT'
  cd /tmp/pscript;
  mkdir /tmp/pscript;
SCRIPT
}

copy_to_server(){
  scp  -i $PEM_FILE  -r * ${USER}@${IP}:/tmp/pscript
}

run_server() {

SERVERS=$(ls servers)
for SERVER in $SERVERS
do
	#copy files
	set_environment $SERVER
	run_command_on_server mkdir /tmp/pscript
	copy_to_server

	#run script
	run_script_on_server
	remove_scripts
done

}

case "$1" in
	"local")
    echo "Run mode local"
	run_script_in_local
    ;;
    "server")
    echo "Run mode server"
    run_server
    ;;
esac