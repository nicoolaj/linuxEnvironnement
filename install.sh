#!/usr/bin/env bash

#Déclaration des variables globales
status_bash_dotglob=`get_bash_option dotglob`

#### Instanciation des fonctions
generic_install(){
	mkdir -p /$FLD/
	cp $FLD/* /$FLD/
}


get_bash_option(){
	shopt |grep $1
}

set_bash_option(){
	if [ "$2" = "off" ]; then
		#pour off
		OPT="-u"
	else
		#pour on
		OPT="-s"
	fi
	shopt $OPT $1
}

installation_bin(){
	FLD=usr/local/bin
	generic_install $FLD
	chmod +x /$FLD/*
}

installation_home(){
	QUI=`whoami`
	HOME_QUI=`getent passwd $QUI | cut -f6 -d:`
	set_bash_option dotglob "on"
	cp home/user/* $HOME_QUI/
	set_bash_option "dotglob" "$status_bash_dotglob"
}
installation_debian(){
	apt-get install -y \
	bzip2 \
	ghostscript git-core gzip \
	screen sshfs \
	tar \
	unzip \

}


#### Lancement des fonctions
installation_bin
installation_home

#### suppression des variables globales
unset status_bash_dotglob