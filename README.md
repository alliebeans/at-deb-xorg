# @deb:xorg

Installation/configuration script of [Debian](https://www.debian.org/).

## OVERVIEW

### System

* bspwm
* sxhkd
* polybar
* LightDM
* picom
* dunst
* Mostly GTK-based or Xfce apps:
  * nemo
  * xfce4-terminal
  * Mousepad
  * xfce4-screenshooter
  * and more

### Filesystem

* btrfs + LUKS encryption + TPM 2.0 decryption
* grub-btrfs
* snapper
* zramswap

##### Subvolume layout:

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

### Theming

* at-deb-theme:
  * Base GTK theme: dark/light minimal gray theme with cyan accents, based on [Cloudy-Gtk-Themes](https://github.com/i-mint/Cloudy).
  * Matching [VS Code](vscode) theme, terminal and [Mousepad](mousepad) color schemes.
  * Matching LightDM GTK theme.
  * Matching QT5 settings: color scheme, .qss theme.
  * Modified [Boston-Icons](https://github.com/thecheis/Boston-Icons) with matching colors.
* Minimal polybar with [Material Symbols](https://fonts.google.com/icons).
* Rofi-implemented menus:
  * powermenu: lock screen, reboot, poweroff, suspend.  `Super` + `Shift` + `X`.
  * themes: set dark/light theme. Key command: (`Super` + `Shift` + `T`).
  * wallpapers: set wallpapers (`Super` + `Shift` + `W`).
* Default fonts: [Clear Sans](https://github.com/intel/clear-sans) and [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono).

#### Wallpapers

![default](https://raw.githubusercontent.com/alliebeans/at-deb-xorg/main/.extras/screenshots/default.png "default")
![darker](https://raw.githubusercontent.com/alliebeans/at-deb-xorg/main/.extras/screenshots/darker.png "darker")
![lines](https://raw.githubusercontent.com/alliebeans/at-deb-xorg/main/.extras/screenshots/lines.png "lines")
![colorful](https://raw.githubusercontent.com/alliebeans/at-deb-xorg/main/.extras/screenshots/colorful.png "colorful")
<br>
*default*, *darker*, *lines* and *colorful*.

Desktop, DM and lockscreen. The default blue gradient is inspired by the [OS/2 Warp](https://en.wikipedia.org/wiki/OS/2) wallpaper.

### Security

* firewalld
* fail2ban
* Kernel hardening
* macchanger
* scurl: curl SSL wrapper
* and more

Reading list: [Linux Hardening Guide](https://madaidans-insecurities.github.io/guides/linux-hardening.html), [Debian/SecurityManagement](https://wiki.debian.org/SecurityManagement), [Lynis](lynis). And also from [Kicksecure]([kicksecure](https://github.com/Kicksecure)).