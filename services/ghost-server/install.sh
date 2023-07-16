#!/bin/bash

apt-get update -y

apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common sudo jq wget git certbot python3-certbot-nginx

curl -L https://github.com/docker/compose/releases/download/2.20.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

docker-compose --version

curl -fsSL https://get.docker.com/ -o get-docker.sh
sh get-docker.sh

curl -s https://api.github.com/repos/bcicen/ctop/releases/latest | grep browser_download_url | grep linux-amd64 | cut -d '"' -f 4 | wget -i -

chmod +x ctop-*-linux-amd64

mv ctop-*-linux-amd64 /usr/local/bin/ctop

systemctl stop nginx

systemctl disable nginx

certbot certonly --non-interactive --agree-tos -m fonalex45@gmail.com --standalone -d blog.r0land.link

mkdir -p /opt/ghost_content
mkdir -p /opt/ghost_mysql
mkdir -p /opt/ghost_nginx
mkdir -p /opt/ghost_compose

chmod 777 /opt/ghost_content
chmod 777 /opt/ghost_mysql
chmod 777 /opt/ghost_nginx
chmod 777 /opt/ghost_compose

touch /opt/ghost_nginx/default.conf

usermod -aG docker admin

reboot
