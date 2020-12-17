terraform{
  required_version = "0.14.2"
  required_providers{
    aws = {
    source = "hashicorp/aws"
      version = "<=3.21.0" 
    }
    template = {
      source = "hashicorp/template"
      version = "<=2.2.0"
    }
  }
}
provider "aws" {
  region = var.aws-region
  //If not using a AWS Cloud9 environment
  //access_key = var.access-key
  //secret_key = var.secret-key
}
module "networking" {
  source      = "./networking"
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

#Key pairs
module "nodejs-key-pair" {
  source          = "./key-pairs"
  key-name        = var.nodejs-key-name
  public-key-name = var.nodejs-public-key-name
}

module "ansible-key-pair" {
  source          = "./key-pairs"
  key-name        = var.ansible-key-name
  public-key-name = var.ansible-public-key-name
}

module "ansible-ami-finder" {
  source   = "./ami-finder"
  ami-name = "amzn2"
}
module "ansible-instance" {
  source = "./ansible-instance"

  application = var.application
  environment = var.environment
  #AMI
  amazon-linux-2-server-ami-id = module.ansible-ami-finder.ami-found-id
  #SSH Key names
  nodejs-private-key-name  = var.nodejs-private-key-name
  ansible-private-key-name = var.ansible-private-key-name
  #Subnet
  devops-shared-services-subnet-id = module.networking.devops-shared-services-subnet-id
  #Security Group
  devops-shared-services-security-group = module.security-groups.devops-shared-services-security-group
  #AWS Key pair
  devops-ec2-ansible-key-pair = module.ansible-key-pair.server-key-pair-name
}

module "nodejs-ami-finder" {
  source   = "./ami-finder"
  ami-name = "Ubuntu"
}

module "nodejs-instances" {
  source = "./nodejs-instances"

  application = var.application
  environment = var.environment
  #AMI
  ubuntu-server-ami-id = module.nodejs-ami-finder.ami-found-id
  #Instance Type
  nodejs-instance-type = var.nodejs-instance-type
  #AWS Key pair
  nodejs-key-pair = module.nodejs-key-pair.server-key-pair-name
  #Security Group
  devops-ec2-security-group = module.security-groups.devops-ec2-security-group
  #Ansible Ip
  ansible-private-ip-address = module.ansible-instance.ansible-private-ip-address
  #SSH Key names
  nodejs-private-key-name  = var.nodejs-private-key-name
  ansible-private-key-name = var.ansible-private-key-name

  #Subnets
  devops-public-subnet-a-id = module.networking.devops-public-subnet-a-id
  devops-public-subnet-b-id = module.networking.devops-public-subnet-b-id
}

module "application-load-balancer" {
  source = "./application-load-balancer"

  application = var.application
  environment = var.environment

  devops-vpc-id                   = module.networking.devops-vpc-id
  devops-nodejs-ec2-instance-a-id = module.nodejs-instances.devops-nodejs-ec2-instance-a-id
  devops-nodejs-ec2-instance-b-id = module.nodejs-instances.devops-nodejs-ec2-instance-b-id
  devops-public-subnet-a-id       = module.networking.devops-public-subnet-a-id
  devops-public-subnet-b-id       = module.networking.devops-public-subnet-b-id
  devops-alb-security-group       = module.security-groups.devops-alb-security-group
}

module "nodejs-launch-template" {
  source = "./nodejs-launch-template"

  application = var.application
  environment = var.environment
  #Ansible Key
  ansible-private-key-name = var.ansible-private-key-name
  #Ansible private ip
  ansible-private-ip-address = module.ansible-instance.ansible-private-ip-address
  #Ubuntu AMI
  nodejs-server-ami-id = module.nodejs-ami-finder.ami-found-id
  #Instance Type
  nodejs-instance-type = var.nodejs-instance-type
  #SSH Key names
  nodejs-private-key-name = var.nodejs-private-key-name
  #AWS Key pair
  nodejs-key-pair = module.nodejs-key-pair.server-key-pair-name
  #Security Group
  devops-ec2-security-group = module.security-groups.devops-ec2-security-group
  #Subnets
  devops-public-subnet-a-id = module.networking.devops-public-subnet-a-id
  devops-public-subnet-b-id = module.networking.devops-public-subnet-b-id
  #Target Group
  devops-nodejs-instances-target-group-arn = module.application-load-balancer.devops-nodejs-instances-target-group-arn

}
