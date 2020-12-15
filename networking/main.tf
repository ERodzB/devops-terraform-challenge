
#Main VPC
resource "aws_vpc" "devops-main-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    product     = "DevOps"
    application = var.application
    environment = var.environment
  }
}
#Shared Services Subnet
resource "aws_subnet" "devops-shared-services-subnet" {
  vpc_id                  = aws_vpc.devops-main-vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "${var.aws-region}a"
  map_public_ip_on_launch = true
  tags = {
    product     = "Shared Services"
    application = var.application
    environment = var.environment
  }
}
#Devops Public Subnet #1
resource "aws_subnet" "devops-public-subnet-a" {
  vpc_id                  = aws_vpc.devops-main-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws-region}a"
  map_public_ip_on_launch = true
  tags = {
    product     = "NodeJs"
    application = var.application
    environment = var.environment
  }
}
#Devops Public Subnet #2
resource "aws_subnet" "devops-public-subnet-b" {
  vpc_id                  = aws_vpc.devops-main-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.aws-region}b"
  map_public_ip_on_launch = true
  tags = {
    product     = "NodeJs"
    application = var.application
    environment = var.environment
  }
}
#Internet Gateway
module "internet-gateway" {
  source      = "./internet-gateway"
  application = var.application
  environment = var.environment

  devops-main-vpc-id        = aws_vpc.devops-main-vpc.id
  shared-services-subnet-id = aws_subnet.devops-shared-services-subnet.id
  devops-public-subnet-a-id = aws_subnet.devops-public-subnet-a.id
  devops-public-subnet-b-id = aws_subnet.devops-public-subnet-b.id
}