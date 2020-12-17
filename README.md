# DevOps Challenge with Terraform

## Project Overview
1. Creates the required network in which the Chat-App will use. (1 Main VPC, 3 subnets and a internet gateway).
2. Creates 2 Key pairs for secures access to the EC2 instances.
3. Creates 1 EC2 instance which Ansible will be installed using the ansible.sh bash script and has the Chat-App Ansible playbook.
4. Creates 2 EC2 instances and then installs [Chat-App](https://github.com/abkunal/Chat-App-using-Socket.io), asking the Ansible server for the required configuration files.
5. Creates an Application Load Balancer for distributing the traffic between the Chat-App servers between two AZ.
6. Creates the security policies required to allow servers interaction, accesing via ssh and the traffic between the Application Load Balancer and the Chat-App EC2 instances.
7. Creates a launch configuration to be later be used in a autoscaling group that has Cloudwatch alarms for trigerring the autoscaling policies that the Chat-App EC2 instances uses if needed.

## Project Requirements
- A Amazon Web Services Account.
- Terraform v0.14.2.
### NOTES
* If posible use a AWS Cloud9 environment for deploying the following infrastructure if not create a IAM user with an AWS Access key and AWS Access token. (Be sure to have the right user permissions)
* If using a IAM user be sure to remove the commented lines at the main module provider and add your access keys to your own variables.

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

### Creating SSH keys

Create SSH keys for the EC2 instances

1. at the project root directory create a folder name "ssh-keys"
```
$ mkdir ssh-keys
```
2. Go to the created directory and proceed to generate the SSH keys
```
$ cd ssh-keys
$ ssh-keygen -f ansible-ec2
$ ssh-keygen -f nodejs-ec2
```
### NOTES
* The created keys must not have a password.
* If you use other SSH key names be sure to set your own key names variables.

# Project Modules Overview

# Main Module
The main.tf contains the reference to the other modules, I decided to took this approach for splitting code and avoid having a big chunk of code.
### Module Variables
| Variable | Description | Default Value |
| ------ | ------ | ------ |
| aws-region |  The AWS region that the infrastructure will be created in. | us-east-1 |
| application | Name of the application that uses this infrastructure. | chatbot |
| environment | Environment in which the infrastructure it's being deployed. | sandbox |
| working-machine-ip | Your working machine IP. (It's required for uploading files and has to end with /32) | 0.0.0.0/0 |
| nodejs-key-name | The name of your SSH key for accesing the EC2 Chat-Apps instances. | nodejs-ec2 |
| ansible-key-name | The name of your SSH key for accesing the Ansible instance. | ansible-ec2 |
| nodejs-private-key-name | The name of your SSH private key that you will use for accesing the EC2 Chat-Apps instances. | nodejs-ec2 |
| ansible-private-key-name | The name of your SSH private key that you will use for accesing the EC2 Ansible instance. | ansible-ec2 |
| nodejs-public-key-name | The name of your SSH public key that it will be uploaded to the EC2 Chat-Apps instances. | nodejs-ec2.pub |
| ansible-public-key-name | The name of your SSH public key that it will be uploaded to the EC2 Ansible instance. | ansible-ec2.pub |
| nodejs-instance-type | The EC2 Chat-app instance type to use.  | t2.micro |
| access-key | Your IAM User Acces key |
| secret-key | Your IAM User Secret key |

### Module Outputs
| Output | Description |
| ------ | ------ |
| ansible-ip-address | Ansible server public ip address.  |
| devops-nodejs-instances-alb-dns | Application Load balancer DNS. |
| devops-nodejs-ec2-instance-a-private-ip | Chat-App server A private ip adress. |
| devops-nodejs-ec2-instance-b-private-ip | Chat-App server B private ip adress. |
| devops-nodejs-ec2-instance-a-public-ip | Chat-App server A public ip adress. |
| devops-nodejs-ec2-instance-b-public-ip | Chat-App server B public ip adress. |

# Module ami-finder 
Module that searches for the latest AMI.

### Module Variables
| Variable | Description |
| ------ | ------ |
| ami-name | The name of the OS to look for. |

### Module Outputs
| Output | Description |
| ------ | ------ |
| ami-found-id | Returns the AMI ID. |

# Module ansible-instance 
Module that creates a EC2 instance that then runs the ansible.sh bash script to install Ansible.

### Module Variables
| Variable | Description |
| ------ | ------ |
| devops-ec2-ansible-key-pair | The Ansible key pair for accesing the instance via SSH. |
| devops-shared-services-security-group | The Security group which the Ansible server will use. |
| devops-shared-services-subnet-id | The subnet which the Ansible server will use. |
| nodejs-private-key-name | The Chat-App private key pair name for using the Ansible playbook with SSH. |
| ansible-private-key-name | The Ansible private key pair name for uploading the script via SSH. |
| amazon-linux-2-server-ami-id | The Amazon Linux 2 Latest AMI Id. |
| application | Name of the application that will be used for tagging. |
| environment | Name of Environment that will be used for tagging. |

### Module Outputs
| Output | Description |
| ------ | ------ |
| ansible-ip-address | Returns the Ansible server public ip address. |
| ansible-private-ip-address | Returns the Ansible server private ip address. |

# Module application-load-balancer 
Module that creates the application load balancer used by the Chat-App servers.

### Module Variables
| Variable | Description |
| ------ | ------ |
| devops-public-subnet-a-id | The public subnet A ID in which the application load balancer will use for distributing traffic. |
| devops-public-subnet-b-id | The public subnet B ID in which the application load balancer will use for distributing traffic. |
| devops-alb-security-group | The Security group which the Application Load Balancer will use. |
| devops-vpc-id | The vpc ID in which the application load balancer will be created in. |
| devops-nodejs-ec2-instance-a-id | The EC2 Chat-App instance A ID for attaching it to a target group. |
| devops-nodejs-ec2-instance-b-id | The EC2 Chat-App instance B ID for attaching it to a target group. |
| application | Name of the application that will be used for tagging. |
| environment | Name of Environment that will be used for tagging. |

### Module Outputs
| Output | Description |
| ------ | ------ |
| devops-nodejs-instances-alb-dns | Application Load balancer DNS. |
| devops-nodejs-instances-target-group-arn | The arn of Application Load Balancer target group to be later use for the autoscaling group. |

## Sub Module target-groups/application-load-balancer 
Module that creates the target groups used by the application load balancer.

### Sub Module Variables
| Variable | Description |
| ------ | ------ |
| devops-vpc-id | The vpc ID in which the target groupp will be created in. |
| devops-nodejs-instances-alb-arn | The Application Load Balancer ARN for attaching a port listener. |
| devops-nodejs-ec2-instance-a-id | The EC2 Chat-App instance A ID for attaching it to a target group. |
| devops-nodejs-ec2-instance-b-id | The EC2 Chat-App instance B ID for attaching it to a target group. |
| application | Name of the application that will be used for tagging. |
| environment | Name of Environment that will be used for tagging. |

### Sub Module Outputs
| Output | Description |
| ------ | ------ |
| devops-nodejs-instances-target-group-arn | The arn of Application Load Balancer target group to be later use for the autoscaling group. |

# Module key-pairs 
Module that creates the AWS Key pairs used by the servers.

### Module Variables
| Variable | Description |
| ------ | ------ |
| key-name | Name that will be used to create the AWS Key pair. |
| public-key-name | Name of SHH public key that will be used to create the AWS Key pair. |

### Module Outputs
| Output | Description |
| ------ | ------ |
| server-key-pair-name | Name of the created AWS Key pair. |

# Module networking 
Module that creates 1 vpc with cidr 10.0.0.0/16 which has 3 subnets that uses internet gateways for accesing the internet.

The following subnets are created:
- devops-shared-services-subnet 10.0.0.0/24
- devops-public-subnet-a 10.0.1.0/24
- devops-public-subnet-b 10.0.2.0/24

### Module Variables
| Variable | Description |
| ------ | ------ |
| aws-region |  The AWS region that the vpc will be created in. | us-east-1. |
| application | Name of the application that will be used for tagging. |
| environment | Name of Environment that will be used for tagging. |
## Module Outputs
| Output | Description |
| ------ | ------ |
| devops-vpc-id | The ID of the main VPC. |
| devops-shared-services-subnet-id | The Subnet ID of shared services. |
| devops-public-subnet-a-id | The public subnet A ID of shared services.  |
| devops-public-subnet-b-id | The public subnet B ID of shared services.  |
## Sub Module internet-gateway/networking 
Sub module which give access to  internet for the created subnets.

### Module Variables
| Variable | Description |
| ------ | ------ |
| devops-main-vpc-id |  The main VPC ID in which the internet gateway will be created. |
| devops-shared-services-subnet-id | The Subnet ID of shared services. |
| devops-public-subnet-a-id | The public subnet A ID.   |
| devops-public-subnet-b-id | The public subnet B ID.   |
| application | Name of the application that will be used for tagging. |
| environment | Name of Environment that will be used for tagging. |

# Module nodejs-instances
Module that creates 2 EC2 instances.

### Module Variables
| Variable | Description |
| ------ | ------ |
| nodejs-key-pair | The Chat-App key pair for accesing the instance via SSH. |
| devops-ec2-security-group | The Security group which the Chat-App server will use. |
| devops-public-subnet-a-id | The public subnet A ID in which  instance A will run. |
| devops-public-subnet-b-id | The public subnet B ID in which  instance B will run. |
| ubuntu-server-ami-id | The Ubuntu Latest AMI Id  |
| nodejs-instance-type | The EC2 Chat-app instance type will use. |
| ansible-private-ip-address | The ansible private ip for running the ansible playbook. |
| ansible-private-key-name | the ansible private key for accesing via SSH. |
| nodejs-private-key-name | The key that it will use to run the ansible playbook. |
| application | Name of the application that will be used for tagging. |
| environment | Name of Environment that will be used for tagging. |

### Module Outputs
| Variable | Description |
| ------ | ------ |
| devops-nodejs-ec2-instance-a-id | The EC2 Chat-App instance A ID for attaching it to a target group. |
| devops-nodejs-ec2-instance-b-id | The EC2 Chat-App instance B ID for attaching it to a target group. |
| devops-nodejs-ec2-instance-a-private-ip | Chat-App server A private ip address. |
| devops-nodejs-ec2-instance-b-private-ip | Chat-App server B private ip address. |
| devops-nodejs-ec2-instance-a-public-ip | Chat-App server A public ip address. |
| devops-nodejs-ec2-instance-b-public-ip | Chat-App server B public ip address. |

## Sub Module ec2-instance/nodejs-instances
Module that create a EC2 instance which uses the nodejs.sh bash script for asking the Ansible server for configuration.

### Sub Module Variables
| Variable | Description |
| ------ | ------ |
| server-ami-id | the AMI ID that the instance will use to be created. |
| instance-type | The EC2 instance type to use. |
| key-pair-name | The EC2 key pair name for  later accesing the instance via SSH. |
| ec2-security-group | The Security group which the EC2 instance will be created in. |
| ec2-subnet-id | The subnet ID in which the EC2 instance will be created in. |
| ansible-private-key-name | The Ansible SSH private key name for using the Ansible playbook with SSH. |
| ansible-private-ip-address | The Ansible private server ip that the nodejs.sh uses to connect to the Ansible server. |
| nodejs-private-key-name | The Chat-App SSH private key that will use for Ansible playbook. |
| application | Name of the application that will be used for tagging. |
| environment | Name of Environment that will be used for tagging. |
| product | Name of the product that will be used for tagging. |  

### Sub Module Outputs
| Variable | Description |
| ------ | ------ |
| ec2-instance-id | The created EC2 instance ID  |
| ec2-instance-public-ip | The created EC2 instance public IP. |
| ec2-instance-private-ip | The created EC2 instance private IP. |

# Module nodejs-launch-template 
Module that creates a launch configuration to be later be used in a autoscaling group with autoscaling policies and cloudwatch alarms.

### Module Variables
| Variable | Description |
| ------ | ------ |
| nodejs-server-ami-id | The AMI ID that the launch configuration will use. |
| nodejs-instance-type | The EC2 instance type that the launch configuration will use. |
| nodejs-key-pair | The AWS Key pair that the launch configuration will use for accesing them via SSH. |
| devops-ec2-security-group | The Security group which the launch configuration will be created in. |
| devops-public-subnet-a-id | One of the public subnets which the launch configuration will use. |
| devops-public-subnet-b-id | One of the public subnets which the launch configuration will use. |
| devops-nodejs-instances-target-group-arn | In which target group will the instances be launched. |
| nodejs-private-key-name | The SSH key private that the launch configuration it will use to run the ansible playbook. |
| ansible-private-key-name | The SSH key private that the launch configuration will use to access the Ansible Server. |
| application | Name of the application that will be used for tagging. |
| environment | Name of Environment that will be used for tagging. |

### Module Outputs
| Variable | Description |
| ------ | ------ |
| devops-nodejs-auto-scaling-group-name | The name of the created autoscaling group. |

## Sub Module nodejs-auto-scaling-group/nodejs-launch-template 
Module which creates a autoscaling group with the created launch configuration.

### Sub Module Variables
| Variable | Description |
| ------ | ------ |
| devops-nodejs-launch-template-name | Name of the created launch configuration. |
| devops-public-subnet-a-id | One of the public subnets which the autoscaling group will use. |
| devops-public-subnet-b-id | One of the public subnets which the autoscaling group will be created in. |
| devops-nodejs-instances-target-group-arn | The target group which that the autoscaling group will be created in. |
| application | Name of the application that will be used for tagging. |
| environment | Name of Environment that will be used for tagging. |
### Sub Module Outputs
| Variable | Description |
| ------ | ------ |
| devops-nodejs-auto-scaling-group-name | The name of the created autoscaling group. |

## Sub Module nodejs-auto-scaling-policy/nodejs-launch-template 
Module which creates a autoscaling policy wich the created autoscaling group will be using.

### Sub Module Variables
| Variable | Description |
| ------ | ------ |
| devops-nodejs-auto-scaling-group-name | The name of the created autoscaling group. |
| application | Name of the application that will be used for tagging. |
| environment | Name of Environment that will be used for tagging. |

### Sub Module Outputs
| Variable | Description |
| ------ | ------ |
| devops-nodejs-add-servers-autoscaling-policy-arn | The arn of the created autoscaling policy add servers. |
| devops-nodejs-remove-servers-autoscaling-policy-arn | The arn of the created autoscaling policy remove servers. |

## Sub Module nodejs-cloudwatch-alarms/nodejs-launch-template 
Module which creates cloudwatch alarms for triggering the autoscaling policies.

### Sub Module Variables
| Variable | Description |
| ------ | ------ |
| devops-nodejs-auto-scaling-group-name | The name of the created autoscaling group. |
| devops-nodejs-add-servers-autoscaling-policy-arn | The arn of the created autoscaling policy add servers. |
| devops-nodejs-remove-servers-autoscaling-policy-arn | The arn of the created autoscaling policy remove servers. |
| application | Name of the application that will be used for tagging. |
| environment | Name of Environment that will be used for tagging. |

# Module security-groups 
Module that creates a the security groups for allowing the servers interactions, working machine SSH and allowed traffic for the application load balancer.

### Module Variables
| Variable | Description |
| ------ | ------ |
| devops-vpc-id | The main VPC ID in which the internet gateway will be created. |
| working-machine-ip | Your working machine IP for allowing file uploads and accesing the EC2 instances via SSH. |
| application | Name of the application that will be used for tagging. |
| environment | Name of Environment that will be used for tagging. |

### Module Outputs
| Variable | Description |
| ------ | ------ |
| devops-ec2-security-group | The Security group ID in which the Chat-App EC2 instances will be created in. |
| devops-ec2-security-group-arn | The Security group ARN in which the Chat-App EC2 instances will be created in. |
| devops-alb-security-group | The Security group ID which the Application Load Balancer will be using. |
| devops-shared-services-security-group | The Security group ID which the Ansible server will be using. |

# How does the EC2 instances gets it's configuration from the Ansible server
* Everytime a EC2 instance gets launched it executes the nodejs.sh bash script which is in charge of executing the following commands:
1. Creating the Ansible SSH key
2. Know the instance private IP (This step is required for the Ansible server to know to which server the ansible playbook will run)
3. Connecting to the Ansible server and executing a Script that adds the server to the hosts inventory and executes the node.yaml playbook.