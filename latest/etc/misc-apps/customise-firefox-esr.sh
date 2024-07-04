#!/bin/bash

DIR="$(dirname $0)"

if [ -z "$(cat $DIR/userChrome.css)" ]; then
	echo -e "\e\n[1;31m Missing resources, exiting...\e[0m"
	exit 1
fi

_HOME=$HOME
_MKDIR="mkdir"
_CP="cp"


[ $(id -u) = 0 ] && _HOME="/home/$SUDO_USER" && _MKDIR="install -v -o $SUDO_USER -g $SUDO_USER -d" && _CP="install -v -o $SUDO_USER -g $SUDO_USER --mode=644"

ESR_DIR=$(cd $_HOME/.mozilla/firefox/ && find -type d -iname "*.default-esr" | cut -c 3-)
if ! [ -z $ESR_DIR ] && [ -d "$_HOME/.mozilla/firefox/$ESR_DIR" ]; then
	$_MKDIR $_HOME/.mozilla/firefox/$ESR_DIR/chrome/
	$_CP $DIR/userChrome.css $_HOME/.mozilla/firefox/$ESR_DIR/chrome/
	echo -e "\e\n[1;32mFirefox configured.\n\n\e[1;33mRemember to set preference 'toolkit.legacyUserProfileCustomizations.stylesheets' to true in about:config.\e[0m"
else
	echo -e "\e\n[1;33m Warning: required path '.mozilla/firefox/' not found.\nCopy file userChrome.css manually once directory has been created.\e[0m"
fi