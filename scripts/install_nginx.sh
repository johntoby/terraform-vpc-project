#!/bin/bash

# Installing nginx webserver
sudo apt update -y
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

# Install postgresql-client
sudo apt update -y
sudo apt install postgresql-client -y

