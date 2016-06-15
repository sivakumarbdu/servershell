#! /bin/bash

set_environment() {
	source env.sh
	source "servers/$1"
}

run_script_on_server() {
  if [ "$PEM_FILE" == "" ]
    then
    ssh  ${USER}@${IP} << 'SCRIPT'
      cd /tmp/pscript;
      tar -xvf provision_script_server.tar
      ./mod.sh
SCRIPT
  else
    ssh  -i $PEM_FILE ${USER}@${IP} << 'SCRIPT'
      cd /tmp/pscript;
      tar -xvf provision_script_server.tar
      ./mod.sh
SCRIPT
  fi
}

run_script_in_local() {
	./mod.sh
}

remove_scripts() {
  if [ "$PEM_FILE" == "" ]
    then
     echo "pem file not exists"
    ssh  ${USER}@${IP} << 'SCRIPT'
      rm -r /tmp/pscript
SCRIPT
  else
    echo "pem file exists"
    ssh  -i $PEM_FILE ${USER}@${IP} << 'SCRIPT'
      rm -r /tmp/pscript
SCRIPT
  fi
}

remove_server_logs()
{
  if [ "$PEM_FILE" == "" ]
    then
     echo "pem file not exists"
    ssh  ${USER}@${IP} << 'SCRIPT'
      rm -r /tmp/script_log.txt
SCRIPT
  else
    echo "pem file exists"
    ssh  -i $PEM_FILE ${USER}@${IP} << 'SCRIPT'
      rm -r /tmp/script_log.txt
SCRIPT
  fi
}
run_command_on_server() {
echo "run command on server"
if [ "$PEM_FILE" == "" ]
  then
  ssh -o StrictHostKeyChecking=no ${USER}@${IP} << 'SCRIPT'
    cd /tmp/pscript;
    mkdir /tmp/pscript;
SCRIPT
else
  ssh -o StrictHostKeyChecking=no -i $PEM_FILE ${USER}@${IP} << 'SCRIPT'
    cd /tmp/pscript;
    mkdir /tmp/pscript;
SCRIPT
fi
}

copy_to_server(){
  rm provision_script_server.tar
  tar -cvf  provision_script_server.tar . --exclude='servers'  --exclude='examples'  --exclude='.git'
  if [ "$PEM_FILE" == "" ]
    then
    scp -o StrictHostKeyChecking=no -i  provision_script_server.tar ${USER}@${IP}:/tmp/pscript
  else
    scp -o StrictHostKeyChecking=no -i $PEM_FILE  provision_script_server.tar ${USER}@${IP}:/tmp/pscript
  fi
}

copy_log_to_local(){
  if [ "$PEM_FILE" == "" ]
    then
    scp -o StrictHostKeyChecking=no -i   ${USER}@${IP}:/tmp/script_log.txt log/
  else
    scp -o StrictHostKeyChecking=no -i $PEM_FILE  ${USER}@${IP}:/tmp/script_log.txt log/
  fi
}

run_server() {

SERVERS=$(ls servers)
for SERVER in $SERVERS
do
	#copy filesre
	set_environment $SERVER
	run_command_on_server mkdir /tmp/pscript
	copy_to_server

	#run script
	run_script_on_server
	remove_scripts
  copy_log_to_local
  remove_server_logs
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

rm  provision_script_server.tar