#!bin/bash


read -p "Enter your IP address   " ip

if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]];
then
	OIFS=$IFS
	IFS='.'
	ip=($ip)
	IFS=$OIFS
	if [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]];
	then
		echo "Success"
	else 
		echo "IP can't be more than 255"
	fi
	
else 
   echo "Fail -IP not there"
fi 
