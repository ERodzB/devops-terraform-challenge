resource "aws_lb" "devops-nodejs-instances-alb" {
  name               = "devopsLoadBalancer"
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.devops-public-subnet-a-id,var.devops-public-subnet-b-id]
  security_groups    = [var.devops-alb-security-group]
}
resource "aws_lb_target_group" "devops-nodejs-instances-target-group" {
  name     = "devopsNodeJSTargetGroup"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = var.devops-vpc-id
  stickiness {
    type           = "lb_cookie"
    cookie_duration = 3600
    enabled        = true
  }
}
resource "aws_lb_listener" "devops-alb-listener" {
  load_balancer_arn = aws_lb.devops-nodejs-instances-alb.arn
  protocol          = "HTTP"
  port              = 80
  default_action {
    type             = "forward"
    target_group_arn = var.devops-ec2-security-group
  }
}
resource "aws_lb_target_group_attachment" "nodejs-attachment-a" {
  target_group_arn = var.devops-ec2-security-group
  target_id        = var.devops-nodejs-ec2-instance-a-id
}
resource "aws_lb_target_group_attachment" "nodejs-attachment-b" {
  target_group_arn = var.devops-ec2-security-group
  target_id        = var.devops-nodejs-ec2-instance-b-id
}
