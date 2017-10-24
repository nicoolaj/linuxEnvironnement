#!/usr/bin/env bash

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

installation_homedir(){
	QUI=`whoami`
	HOME_QUI=`getent passwd $QUI | cut -f6 -d:`
	set_bash_option dotglob "on"
	cp homeDir/* $HOME_QUI/
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

parametrage_path(){
	echo "" >> ~/.profile
	echo "# set PATH so it includes user's private hidden bin directories" >> ~/.profile
	echo "if [ -d \"\$HOME/.local/bin\" ]; then" >> ~/.profile
	echo "	PATH=\"\$HOME/.local/bin:\$PATH\"" >> ~/.profile
	echo "fi" >> ~/.profile
	echo "" >> ~/.profile

}

#Déclaration des variables globales
status_bash_dotglob=`get_bash_option dotglob`

#### Lancement des fonctions
installation_homedir
installation_debian
parametrage_path

#### suppression des variables globales
unset status_bash_dotglob
