#!/bin/bash
sleep 60
sudo mkdir /etc/ansible-master
printf "%s" ${ssh-key} > /tmp/ssh-key
base64 --decode /tmp/ssh-key > /tmp/${ansible-key-name}
sudo mv /tmp/${ansible-key-name} /etc/ansible-master
cd /etc/ansible-master 
sudo chmod 700 ${ansible-key-name}
privateIP=$(hostname -I | awk '{print $1}')
timeout=0
until sudo ssh ${ansible-private-ip-address} -l ec2-user -i /etc/ansible-master/${ansible-key-name} -o "StrictHostKeyChecking=no"
do
    timeout=$(($timeout+1))
    echo "Waiting to connect" >> log.txt
    sleep 120
    if [ $timeout -eq 7 ] ; then
      echo "Couldn't connect to the ansible server" >> /etc/ansible-master/log.txt
      exit 1
    fi
done
sudo ssh ${ansible-private-ip-address} -l ec2-user -i /etc/ansible-master/${ansible-key-name} -o "StrictHostKeyChecking=no" << EOF
timeout=0
until cat /var/lib/cloud/instance/boot-finished 
do
    sleep 30
    printf "Waiting to start..." >> /tmp/log.txt
    if [ $timeout -eq 7 ] ; then
      echo "Machine coudn't start" >> /tmp/log.txt
      exit 1
    fi
done
timeout=0
until  cd /etc/ansible
do
    timeout=$(($timeout+1))
    echo "Waiting for Ansible to install...." >> /tmp/log.txt
    sleep 120
    if [ $timeout -eq 7 ] ; then
      echo "Couldn't find the required files" >> /tmp/log.txt
      exit 1
    fi
done
cd /etc/ansible
sudo printf "%s\n" $privateIP >> /etc/ansible/hosts
sudo ansible-playbook -i hosts node.yaml --extra-vars "server=$privateIP" --private-key=${nodejs-key-name}
EOF
sudo rm -rf /etc/ansible-master/${ansible-key-name}
