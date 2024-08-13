# ls
alias ls='ls -l --color=auto'
alias la='ls -la --color=auto'

# enable misc dircolors
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# add confirmation when rm/cp
alias rm='rm -i'
alias cp='cp -i'
# copy working directory to clipboard
alias clip='xclip -selection clipboard'

# systemd
alias netreset='sudo systemctl restart networking'
alias dockerstart='sudo systemctl start containerd && sudo systemctl start docker'
alias dockerstop='sudo systemctl stop docker && sudo systemctl stop containerd'

# nmcli
alias wifi='nmcli device wifi'
alias conn='nmcli connection'

# apt
alias update='sudo apt update'
alias upgrade='sudo apt update && sudo apt upgrade'
alias upgradable='apt list --upgradable'
alias install='sudo apt install'
alias remove='sudo apt remove'

# git
alias gits='git status'
alias gitb='git branch'

# xrandr
alias hdmi='xrandr --output HDMI1 --same-as eDP1'
alias laptop='xrandr --output eDP1'


# dotfiles
alias cpdotfiles='rsync -r --files-from=/home/alliebeans/dotfiles /home/alliebeans/ /home/alliebeans/Public/dotfiles/'
alias cpdotconfig='rsync -r --files-from=/home/alliebeans/.config/dotconfig /home/alliebeans/.config/ /home/alliebeans/Public/dotfiles/dotconfig/'
