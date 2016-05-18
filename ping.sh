URL=$1
ping $URL -c 1
if [ "$?" -eq "0" ]
then
echo "Success"
else
echo "Not reachable"
fi
