# DevOps Challenge with Terraform

## Project Overview
1. Creates the required network to run in AWS which is 1 Main VPC, 3 subnets and a internet gateway.
2. Creates 2 Key pairs for secures access to the EC2 instances.
3. Creates 1 EC2 instance with Ansible installed and has the Chat-App Ansible playbook.
4. Creates 2 EC2 instances and then installs [Chat-App](https://github.com/abkunal/Chat-App-using-Socket.io), asking the Ansible server for configuration.
5. Creates an Application Load Balancer for distributing the traffic between the Chat-App servers between two AZ.
6. Creates the security policies required to allow servers interaction, accesing via ssh and the comunication between the Application Load Balancer and the Chat-App EC2 instances.
7. Creates a launch configuration for creating a autoscaling group with Cloudwatch alarms for trigerring the autoscaling policies that the Chat-App EC2 instances uses if needed.
## Project Requirements
- Amazon Web Services Account.
- Terraform v0.14.2.
- Preferably use a AWS Cloud9 environment for creating the following infrastructure if not posible create a IAM user with an AWS Access key and AWS Access token. (Be sure to have the right user permissions)
## Project Installation (For Linux distributions)
### Installing Terraform
1. Downloading Terraform 0.14.2.
```
$ mkdir downloads && cd downloads
$ sudo wget https://releases.hashicorp.com/terraform/0.14.2/terraform_0.14.2_linux_amd64.zip
$ sudo unzip terraform_0.14.2_linux_amd64.zip
```
2. Adding terraform to your running services.
```
$ sudo mv terraform /usr/local/bin/terraform
```
3. To check if Terraform v0.14.2 is installed correctly run the following command.
```
$ terraform -version
```
and it will show you that you have installed terraform 0.14.2.

# Project Modules Overview
## Main Module
The main.tf contains the reference to the other modules, I decided to took this approach for splitting code and avoid having a big chunk of code.
### Main Module Variables
| Variable | Description | Default Value |
| ------ | ------ |
| aws-region |  The AWS region that the infrastructure will be created in. | us-east-1 |
| application | Name of the application that uses this infrastructure | chatbot |
| environment | Environment in which the infrastructure it's being deployed | sandbox |
| working-machine-ip | Your working machine IP. (It's required for upload files and has to end with /32) | 0.0.0.0/0 |
| nodejs-key-name | The name of your SSH key for accesing the EC2 Chat-Apps instances | nodejs-ec2 |
| ansible-key-name | The name of your SSH key for accesing the Ansible instance | ansible-ec2 |
| nodejs-private-key-name | The name of your SSH private key that you will use for accesing the EC2 Chat-Apps instances | nodejs-ec2 |
| ansible-private-key-name | The name of your SSH private key that you will use for accesing the EC2 Ansible instance | ansible-ec2 |
| nodejs-public-key-name | The name of your SSH public key that it will be uploaded to the EC2 Chat-Apps instances | nodejs-ec2.pub |
| ansible-public-key-name | The name of your SSH public key that it will be uploaded to the EC2 Ansible instance | ansible-ec2.pub |
| nodejs-instance-type | The EC2 Chat-app instance type to use  | t2.micro |

