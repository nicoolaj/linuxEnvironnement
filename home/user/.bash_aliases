alias scrmnt='screen -U -D -RR -S montage -t "shell de montage"'
alias filtre="grep -E -v '^(#|;|$|[ ]*#)'"


_ssm_control_c(){
	echo "*** Ouch! Exiting ***"
	exit $?
}

ssum(){
	if [ $# -lt 1 ] ; then
                echo "missing argument SERVER_SHORT_NAME"
        else
		fusermount -u /home/njalibert/Servers/$1
		if [ $? -eq 0 ] ; then
			echo "Demontage OK pour $1"
		else
			echo "Echec de demontage pour $1"
		fi
	fi
}
ssm(){
	if [ $# -lt 1 ] ; then
		echo "missing argument SERVER_SHORT_NAME"
	else
		# trap keyboard interrupt (control-c)
		trap _ssm_control_c SIGINT
		mkdir -p /home/njalibert/Servers/$1
		/usr/bin/sshfs $1:/ /home/njalibert/Servers/$1/
		if [ $? -eq 0 ] ; then
			echo "Montage OK pour $1"
		else
			echo "Echec de montage pour $1"
			fusermount -u /home/njalibert/Servers/$1/
		fi
	fi
}

json(){
	python -mjson.tool $1 > /tmp/$$.json
	if [ $? -eq 0 ] ; then
		mv /tmp/$$.json $1
	fi
}
xml(){
	xmllint --format $1 > /tmp/$$.xml
	if [ $? -eq 0 ] ; then
		mv /tmp/$$.xml $1
	fi

}