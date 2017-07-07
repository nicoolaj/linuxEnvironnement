#!/usr/bin/env bash

#### debut des fonctions ####
generic_install(){
	mkdir -p /$FLD/
	cp $FLD/* /$FLD/
}

installation_bin(){
	FLD = usr/local/bin
	installation_generic $FLD
	chmod +x /$FLD/*
}

installation_home(){
	QUI = `whoami`
	HOME_QUI = `getent passwd $QUI | cut -f6 -d:`
	cp /home/user/* $HOME_QUI/
}
installation_debian(){
	apt-get install -y ghostscript git-core bzip2 tar gzip unzip


}
#### Fin des fonctions ####

installation_bin
installation_home