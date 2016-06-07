#! /bin/bash
#Start Rails webric server, should be placed inside root of rails application

run_server() {
	echo "Trying to run server..."
	PID_FILE=tmp/pids/server.pid
	if [ -s $PID_FILE ]
	then
		PID=$(cat "$PID_FILE")
		echo "PID :  $PID"
		kill -9 $PID
	fi
	bundle exec rails server
}

check_status(){
	if [ "$1" -ne "0" ]
	then
		echo "exit script with status $1"
		exit $1
	fi
}

run_server
check_status $?
