#!/bin/sh

# Check root
if ! [ $(id -u) = 0 ]; then
	echo "\n\n\e[1;31m ERROR: Need root privileges to execute, exiting... \e[0m\n";
	exit 1;
fi

# Check 'default root' snapshot not currently mounted
current="$(cat /proc/cmdline | grep -oP 'subvol=@snapshots/[0-9]+' | grep -oP '[0-9]+')"
if ! [ ${#current} -eq 0 ]; then
	if [ $current -eq 1 ]; then
		echo "\n\n\e[1;31m ERROR: Can't rollback system to 'default root' snapshot, please boot into another snapshot, exiting... \e[0m\n";
		return 1;
	fi
else
	echo "\n\n\e[1;31m ERROR: No rollback snapshot found, exiting... \e[0m\n";
	return 1;
fi

echo -e "\n"

snapper ls

# Confirm
echo "\e\n\n System rollback will be set to the currently booted snapshot: #$current\n\n"
read -p "To continue, type YES: " confirmation

case $confirmation in
	YES ) ;;
	* ) echo "\e\n\nAborting.\n";
        exit 1;;
esac

echo "\e\n\n Creating read-write snapshot from currently booted snapshot."

snapper create --read-write -d "system rollback #$current"

rollback="$(ls -f /.snapshots | sort -rn | head -1)"

rootid_rollback="$(btrfs inspect-internal rootid /.snapshots/$rollback/snapshot)"
btrfs su set-def $rootid_rollback /

echo -e "\n"

update-grub

tmp_dir="/var/tmp/rollback-system"
mkdir -p $tmp_dir
echo $current 1> $tmp_dir/current
echo $rollback 1> $tmp_dir/rollback

echo "\n\n\e[1;33mIMPORTANT!\n1. Boot into 'system rollback #$current' snapshot from GRUB snapshots menu.\n2. Run script 'rollback-system.1.sh' to continue system rollback. \e[0m\n";