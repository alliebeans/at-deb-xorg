# Code

> Notes:<br>
> Remember to './Code/customise'

https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64

# teams-for-linux

sudo mkdir -p /etc/apt/keyrings

sudo wget -qO /etc/apt/keyrings/teams-for-linux.asc https://repo.teamsforlinux.de/teams-for-linux.asc

echo "deb [signed-by=/etc/apt/keyrings/teams-for-linux.asc arch=$(dpkg --print-architecture)] https://repo.teamsforlinux.de/debian/ stable main" | sudo tee /etc/apt/sources.list.d/teams-for-linux-packages.list

sudo apt update

sudo apt install teams-for-linux

# discord

https://discord.com/api/download?platform=linux&format=deb

# rustup

https://www.rust-lang.org/tools/install

# git-lfs

https://github.com/git-lfs/git-lfs/releases

# gh

>   Notes:<br>
>   Remember to 'gh auth login'

https://cli.github.com/

# Docker

>   Notes:<br>
>   For integrating with firewalld:<br>
>   https://dev.to/soerenmetje/how-to-secure-a-docker-host-using-firewalld-2joo

https://docs.docker.com/engine/install/debian/
