#EC2 instances security group
resource "aws_security_group" "devops-ec2-security-group" {
  name        = "devops_ssh"
  description = "Allow ssh to EC2 instances"
  vpc_id      = var.devops-vpc-id
  ingress {
    description = "Allow ssh from Shared services subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }
  ingress {
    description = "Allow ssh from local machine"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.working-machine-ip]
  }
  ingress {
    description     = "Allow traffic from ALB"
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.devops-alb-security-group.id]
  }
  ingress {
    description     = "Allow HTTP traffic from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.devops-alb-security-group.id]
  }
  ingress {
    description     = "Allow HTTPS traffic from ALB"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.devops-alb-security-group.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#Application Load Balancer security group
resource "aws_security_group" "devops-alb-security-group" {
  name        = "devops_alb_security_group"
  description = "Allow traffic from http and https"
  vpc_id      = var.devops-vpc-id
  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#Shared Services Security Group
resource "aws_security_group" "shared-services-security-group" {
  name        = "shared_services_security_group"
  description = "Allow interaction with other subnets"
  vpc_id      = var.devops-vpc-id
  ingress {
    description = "Allow ssh from public subnets"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", var.working-machine-ip]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}