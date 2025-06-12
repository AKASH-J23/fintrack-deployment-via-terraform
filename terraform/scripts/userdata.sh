#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y python3 python3-pip python3-venv git

cd /home/ubuntu
sudo mkdir -p fintrack
sudo chown ubuntu:ubuntu fintrack
cd fintrack

git clone https://github.com/AKASH-J23/fintrack-deployment-via-terraform.git .

python3 -m venv venv
source venv/bin/activate

pip install -r requirements.txt

gunicorn app:app --bind 0.0.0.0:5001 --workers 4 --daemon