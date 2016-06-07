#! /bin/bash

set_environment() {
	source env.sh
	source "servers/$1"
}


run_script_on_server() {

ssh  -i $PEM_FILE ${USER}@${IP} << 'SCRIPT'
  cd /tmp/pscript;
  tar -xvf provision_script_server.tar
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
ssh -o StrictHostKeyChecking=no -i $PEM_FILE ${USER}@${IP} << 'SCRIPT'
  cd /tmp/pscript;
  mkdir /tmp/pscript;
SCRIPT
}

copy_to_server(){
  rm provision_script_server.tar
  tar -cvf  provision_script_server.tar . --exclude='servers'
  scp -o StrictHostKeyChecking=no -i $PEM_FILE  provision_script_server.tar ${USER}@${IP}:/tmp/pscript
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

run_in_single_node(){
	set_environment $1
	run_command_on_server mkdir /tmp/pscript
	copy_to_server

	#run script
	run_script_on_server
	remove_scripts
}


case "$1" in
	"local")
    echo "Run mode local"
	run_script_in_local
    ;;
    "server")
    echo "Run mode server"
    if [ -e "servers/${2}.sh" ]
    	then
    	echo "Running script on $2"
    	run_in_single_node $2
    else
    	run_server
    fi
    ;;
esac