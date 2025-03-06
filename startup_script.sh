#!/bin/bash

sudo apt update
sudo apt install -y apache2
sudo apt install ufw

sudo ufw allow 'WWW'

sudo systemctl restart apache2