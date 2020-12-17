# DevOps Challenge with Terraform
This projects does the following
1. Creates the required network to run in AWS.
2. Creates Key pairs for secures access to the EC2 instances.
3. Creates 1 EC2 instance with Ansible installed and with the Chat-App Ansible playbook.
4. Creates 2 EC2 instances and then installs [Chat-App](https://github.com/abkunal/Chat-App-using-Socket.io), asking the Ansible server for configuration.
5. Creates an Application Load Balancer for distributing the traffic between the Chat-App servers
6. Creates the security policies required to allow servers interaction, accesing via ssh and comunication between the Chat-App EC2  instances with the Application Load Balancer
7. Creates a launch configuration for a autoscaling policy that the Chat-App EC2 instances uses.
## Project Requirements
- Amazon Web Services Account
- Terraform 0.14.2
- Preferably a AWS Cloud9 environment for creating the infrastructure (Be sure to have the right user permissions)
## Project Installation (For Linux distributions)
### Installing Terraform
1. Downloading Terraform 0.14.2
```
$ mkdir downloads && cd downloads
$ sudo wget https://releases.hashicorp.com/terraform/0.14.2/terraform_0.14.2_linux_amd64.zip
$ sudo unzip terraform_0.14.2_linux_amd64.zip
```
2. Adding terraform to your running services
```
$ sudo mv terraform /usr/local/bin/terraform
```
3. To check if terraform is installed correctly run the followin command
```
$ terraform -version
```
and it will show you that you have installed terraform 0.14.2

