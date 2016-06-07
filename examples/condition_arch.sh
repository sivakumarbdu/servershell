#! /bin/bash

ARCH=$(arch)

if [ "$ARCH" == "x86_64" ]
then
echo "You are using 64 bit machine"
else
echo "You are using 32 bit machine"
fi
