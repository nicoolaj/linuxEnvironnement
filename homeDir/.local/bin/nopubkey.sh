#!/bin/bash
if [ $# -eq 1 ]; then
	NOPUBKEY_ENTRY=$1
	NOPUBKEY_SHORT=${NOPUBKEY_ENTRY:(-8)}
	gpg --keyserver pgpkeys.mit.edu --recv-key $NOPUBKEY_SHORT
	gpg -a --export $NOPUBKEY_SHORT | sudo apt-key add -
	unset NOPUBKEY_ENTRY
	unset NOPUBKEY_SHORT
else
	echo "Usage : $0 12345678"
	echo "  for key 90ABCDEF12345678"
fi
