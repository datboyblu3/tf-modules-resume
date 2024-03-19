#!/bin/bash

apt-get update -y

apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common sudo jq wget git certbot python3-certbot-nginx

curl -L https://github.com/docker/compose/releases/download/2.20.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

docker-compose --version

curl -fsSL https://get.docker.com/ -o get-docker.sh
sh get-docker.sh

systemctl stop nginx

systemctl disable nginx

certbot certonly --non-interactive --agree-tos -m fonalex45@gmail.com --standalone -d fr3d.cloud

mkdir -p /opt/ghost_content
mkdir -p /opt/ghost_mysql
mkdir -p /opt/ghost_nginx
mkdir -p /opt/ghost_compose

chmod 777 /opt/ghost_content
chmod 777 /opt/ghost_mysql
chmod 777 /opt/ghost_nginx
chmod 777 /opt/ghost_compose

touch /opt/ghost_nginx/default.conf

usermod -aG docker fr3d

reboot
