# @deb:xorg

> Version 1.0

## Prerequisites

Installer scripts assumes a minimal Debian 12 installation. Partitioning partially needs to be done manually - follow the instructions below.

## 1. Instructions -- Debian GNU/Linux 12 installer

Choose `Advanced options > Expert install`.

### 1.1 Partition disks

**1)**

Select the following:
* Partitioning method: `Guided - use entire disk and set up encrypted LVM`.
* Partitioning scheme: `All in one partition`

Write changes to disk.

**2)**

Delete the auto-configured swap partition:
* Go to `Configure the Logical Volume Manager` and write changes to disk.
* Delete `swap` and `root` logical volumes.
* Create a new `root` logical volume.
* `Finish`.

Edit the newly created `root` LV (partition #1):
* Partition settings: `Use as: btrfs`, `Mount point: /`
* `Done setting up the partition`.

Select `Finish partitioning and write changes to disk`.

If prompted, continue installation without creating a swap space.

### 1.2 Manually setting up the subvolume layout

Before installing the base system, we need to manually configure the subvolume layout.

##### Btrfs subvolume layout:

```
|-@
|-@snapshots
  |-@snapshots/#/snapshot
|-@home
  |-@home/.snapshots/#/snapshot
|-@tmp
|-@var_log
|-@var_tmp
```

**1)**

Activate BusyBox:
* Go to next console by pressing `Ctrl` + `Alt` + F2.
* Press Enter to activate.

Run `df -h`.

Take note of partition names mounted on /target, /target/boot and /target/boot/efi, e.g. `sda2`, `sda1`.

Unmount:
* `umount /target/boot/efi`
* `umount /target/boot`
* `umount /target`

**2)**

We will now create our subvolumes on `/mnt`.

Mount logical group `dev/mapper/...` on `/mnt`:
* `mount /dev/mapper/... /mnt`

Change directories to `/mnt`. `ls` will show one subvolume `@rootfs`.

Following popular convention, rename @rootfs to @. (Also needed for tools such as [timeshift](timeshift)).
* `mv @rootfs @`

Create subvolumes:
* `btrfs su cr @snapshots`
* `btrfs su cr @home`
* `btrfs su cr @tmp`
* `btrfs su cr @var_log`
* `btrfs su cr @var_tmp`

**3)**

Re-mount logical group:
* `mount -o noatime,compress=zstd:1,subvol=@ /dev/mapper/... /target`

> zstd:1 means no compression, default is compression level 3

Create directories for subvolumes on /target:
* `cd /target`
* `mkdir -p boot/efi`
* `mkdir .snapshots`
* `mkdir home`
* `mkdir tmp`
* `mkdir -p var/log`
* `mkdir -p var/tmp`

Mount subvolumes:
* `mount -o noatime,compress=zstd:1,subvol=@snapshots /dev/mapper/... /target/.snapshots/`
* `mount -o noatime,compress=zstd:1,subvol=@home /dev/mapper/... /target/home/`
* `mount -o noatime,compress=zstd:1,subvol=@tmp /dev/mapper/... /target/tmp/`
* `mount -o noatime,compress=zstd:1,subvol=@var_log /dev/mapper/... /target/var/log/`

Etc...

Mount the other partitions, e.g. sda2 at boot and after that sda1 at boot/efi:
* `mount /dev/... boot`
* `mount /dev/... boot/efi`

**4)**

Manually edit fstab.

`nano /target/etc/fstab`

Change btrfs entry to match our @ subvolume, using the same mount options as before.

For example:
* /dev/mapper/... /    btrfs     noatime,compress=......,subvol=@
* /dev/mapper/... /.snapshots    btrfs    noatime,compress=......,subvol=@snapshots

Etc...

> Tip: cut (Ctrl + K) and paste (Ctrl + U) for the other subvolumes, matching name and mount options.

**5)**

Leave current directory, `cd /`, and unmount `/mnt`.

Exit BusyBox, go back to installer by pressing `Ctrl` + `Alt` + F1.

### 1.3 Install base system

When prompted, choose the following:
* Non-free firmware, non-free software, backports.
* Only standard system utilities, no desktop environment.

Finish the installer.

## 2. After first boot into Debian

> Note: installer scripts are only *mostly* automatic, remember to carefully follow all instructions.

1. If installation files are located on root mounted USB mass storage. From mount directory, run `$ ./run_as_sudo` to copy all relevant files into ~.

2. Populate ~ with standard user directories by running `at-deb-xorg/run_as_user`.

3. Run installer script `at-deb-xorg/install` with parameters in the following order:
  1. `at-deb-xorg/install filesystem`
  2. `at-deb-xorg/install base`
  3. `at-deb-xorg/install harden`
  4. `at-deb-xorg/install xorg`
  5. `at-deb-xorg/install configure`

## 3. Using btrfs/snapper/grub-btrfs

##### Btrfs subvolume layout:

```
|-@
|-@snapshots
  |-@snapshots/#/snapshot
|-@home
  |-@home/.snapshots/#/snapshot
|-@tmp
|-@var_log
|-@var_tmp
```

### 3.1 How snapshots are used in this setup

The 'default root' snapshot is the snapshot we are currently booted into and represent our current system. In this setup, the 'default root' snapshot is always stored at `/.snapshots/1/snapshot`.

### 3.2 System rollback

Performing a system rollback means that the 'default root' snapshot is replaced with another snapshot. Since `snapper` creates read-only snapshots by default, we need to perform the rollback in stages.

#### Instructions

> **TODO:** Automate with scripts and associated systemd service.

1. Boot into the desired rollback snapshot from the GRUB snapshots menu.
2. Run the first rollback script, `usr/local/sbin/rollback-system.0.sh`.
3. Reboot and boot into the newly created snapshot named 'system rollback #{rollback snapshot number}' from GRUB snapshots menu.
4. Run second rollback script, `usr/local/sbin/rollback-system.1.sh`.
5. Reboot into the updated 'default root' snapshot from GRUB snapshots menu.
6. Run `update-grub` and reboot normally to complete system rollback.