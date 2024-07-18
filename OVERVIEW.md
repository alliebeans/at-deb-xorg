# @deb:xorg

## OVERVIEW

### System

* bspwm
* sxhkd
* polybar
* LightDM
* nemo
* Mostly GTK-based or Xfce apps.

### Theming

* at-deb-theme:
  * Base GTK theme: dark/light gray theme with cyan accents¹.
    * Dark/light theme can be changed with key command `Super` + `Shift` + `T`.
  * Matching [VS Code](vscode) theme, terminal and [Mousepad](mousepad) color schemes.
  * Matching LightDM GTK theme.
  * Matching QT5 settings: color scheme, .qss theme.
  * [Boston-Icons](https://github.com/thecheis/Boston-Icons) with modified matching colors.
* Minimal polybar with [Material Symbols](https://fonts.google.com/icons) and rofi-implemented power menu.
* Default fonts: [Clear Sans](https://github.com/intel/clear-sans) and [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono).

¹ Base GTK theme is a modified version of [Cloudy-Gtk-Themes](https://github.com/i-mint/Cloudy).

#### Wallpapers

*default*, *darker*, *lines* and *colorful*.
Desktop, DM and lockscreen wallpapers that can be changed with key command `Super` + `Shift` + `W`. <br>
The default blue gradient is inspired by a [OS/2 Warp](https://en.wikipedia.org/wiki/OS/2) wallpaper.

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

### Security

* firewalld
* fail2ban
* Kernel hardening
* macchanger
* scurl: curl SSL wrapper
* and more

Reading list: [Linux Hardening Guide](https://madaidans-insecurities.github.io/guides/linux-hardening.html), [Debian/SecurityManagement](https://wiki.debian.org/SecurityManagement), [Lynis](lynis). And also from [Kicksecure]([kicksecure](https://github.com/Kicksecure)).
