resource "aws_lb" "devops-nodejs-instances-alb" {
  name               = "devopsNodeJSLoadBalancer${var.environment}"
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.devops-public-subnet-a-id, var.devops-public-subnet-b-id]
  security_groups    = [var.devops-alb-security-group]
  tags = {
    product     = "NodeJs"
    application = var.application
    environment = var.environment
  }
}

module "target-groups" {
  source = "./target-groups"

  application = var.application
  environment = var.environment

  devops-vpc-id                   = var.devops-vpc-id
  devops-nodejs-instances-alb-arn = aws_lb.devops-nodejs-instances-alb.arn
  devops-nodejs-ec2-instance-a-id = var.devops-nodejs-ec2-instance-a-id
  devops-nodejs-ec2-instance-b-id = var.devops-nodejs-ec2-instance-b-id
}