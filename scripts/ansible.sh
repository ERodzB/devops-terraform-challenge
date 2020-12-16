#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install ansible2 -y
cd /etc/ansible
sudo chmod -R o+rw /etc/ansible
printf "\n[node-servers:vars]\nansible_user=ubuntu\nansible_conection=ssh\nansible_ssh_private_key_file=$PWD/${nodejs-key-name}" >> hosts
printf "\n[node-servers]\n" >> hosts
printf "\n[defaults]\nhost_key_checking = False\n" >> ansible.cfg
sudo mv /tmp/${nodejs-key-name} /etc/ansible
sudo mv /tmp/node.yaml /etc/ansible
sudo mv /tmp/ping.yaml /etc/ansible