provider "aws" {
  region = var.aws-region
  //If not using a AWS Cloud9 environment
  //access_key = var.access-key
  //secret_key = var.secret-key
}
module "networking" {
  source = "./networking"

  application = var.application
  environment = var.environment
  aws-region  = var.aws-region
}
module "security-groups" {
  source = "./security-groups"

  application        = var.application
  environment        = var.environment
  devops-vpc-id      = module.networking.devops-vpc-id
  working-machine-ip = var.working-machine-ip
}
module "key-pairs" {
  source                  = "./key-pairs"
  nodejs-key-name         = var.nodejs-key-name
  ansible-key-name        = var.ansible-key-name
  nodejs-public-key-name  = var.nodejs-public-key-name
  ansible-public-key-name = var.ansible-public-key-name
}
module "ami-finder"{
  source = "./ami-finder"
}
module "nodejs-instances" {
  source = "./nodejs-instances"

  application = var.application
  environment = var.environment
  #AMI
  ubuntu-server-ami-id = module.ami-finder.ubuntu-server-ami-id
  #AWS Key pair
  nodejs-key-pair = module.key-pairs.devops-ec2-nodejs-key-pair
  #Security Group
  devops-ec2-security-group = module.security-groups.devops-ec2-security-group
  #Subnets
  devops-public-subnet-a-id = module.networking.devops-public-subnet-a-id
  devops-public-subnet-b-id = module.networking.devops-public-subnet-b-id
}
module "ansible-instance" {
  source = "./ansible-instance"

  application = var.application
  environment = var.environment
  #AMI
  amazon-linux-2-server-ami-id = module.ami-finder.amazon-linux-2-server-ami-id
  #SSH Key names
  nodejs-private-key-name  = var.nodejs-private-key-name
  ansible-private-key-name = var.ansible-private-key-name
  #Subnet
  devops-shared-services-subnet-id = module.networking.devops-shared-services-subnet-id
  #Security Group
  devops-shared-services-security-group = module.security-groups.devops-shared-services-security-group
  #AWS Key pair
  devops-ec2-ansible-key-pair = module.key-pairs.devops-ec2-ansible-key-pair
  #NodeJs instances IP
  devops-nodejs-ec2-instance-a-private-ip = module.nodejs-instances.devops-nodejs-ec2-instance-a-private-ip
  devops-nodejs-ec2-instance-b-private-ip = module.nodejs-instances.devops-nodejs-ec2-instance-b-private-ip
}
module "application-load-balancer" {
  source = "./application-load-balancer"

  application = var.application
  environment = var.environment

  devops-vpc-id                   = module.networking.devops-vpc-id
  devops-ec2-security-group-arn   = module.security-groups.devops-ec2-security-group-arn
  devops-nodejs-ec2-instance-a-id = module.nodejs-instances.devops-nodejs-ec2-instance-a-id
  devops-nodejs-ec2-instance-b-id = module.nodejs-instances.devops-nodejs-ec2-instance-b-id
  devops-public-subnet-a-id       = module.networking.devops-public-subnet-a-id
  devops-public-subnet-b-id       = module.networking.devops-public-subnet-b-id
  devops-alb-security-group       = module.security-groups.devops-alb-security-group
  devops-ec2-security-group       = module.security-groups.devops-ec2-security-group
}
