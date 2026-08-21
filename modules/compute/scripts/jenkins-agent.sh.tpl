#!/bin/bash
set -e
apt update -y
apt install -y python3 python3-apt

mkdir -p /home/ubuntu/.ssh
echo "${public_key}" >> /home/ubuntu/.ssh/authorized_keys
chmod 700 /home/ubuntu/.ssh
chmod 600 /home/ubuntu/.ssh/authorized_keys
chown -R ubuntu:ubuntu /home/ubuntu/.ssh