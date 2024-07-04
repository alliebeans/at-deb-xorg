#!/bin/sh

# Check root
if ! [ $(id -u) = 0 ]; then
	echo "\n\n\e[1;31m ERROR: Need root privileges to execute, exiting... \e[0m\n";
	exit 1;
fi

tmp_dir="/var/tmp/rollback-system"

current="$(cat $tmp_dir/current)"
rollback="$(cat $tmp_dir/rollback)"

if 	! [ ${#current} -gt 0 ] ||
	! [ ${#rollback} -gt 0 ]; then
	echo "\n\n\e[1;31m ERROR: Variables not found, exiting... Reboot system. \e[0m\n";
	exit 1;
fi

echo "\e\n\n Update 'default root' snapshot."

snapper rm 1

mkdir -p /.snapshots/1

btrfs su snap /.snapshots/$rollback/snapshot /.snapshots/1

cp -r /.snapshots/$rollback/info.xml /.snapshots/1/

sed -i "s/<num>$rollback<\/num>/<num>1<\/num>/" /.snapshots/1/info.xml
sed -i "s/<description>system rollback #$current<\/description>/<description>default root<\/description>/" /.snapshots/1/info.xml

rootid_next_default="$(btrfs inspect-internal rootid /.snapshots/1/snapshot)"
btrfs su set-def $rootid_next_default /

echo "\e\n\n Cleanup temporary files."

rm -rf $tmp_dir

update-grub

echo "\n\n\e[1;33m1. Boot into updated 'default root' from GRUB snapshots menu.\n2. Run 'update-grub' and reboot normally to complete system rollback. \e[0m\n";