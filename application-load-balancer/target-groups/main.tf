resource "aws_lb_target_group" "devops-nodejs-instances-target-group" {
  name     = "devopsNodeJSTargetGroup${var.environment}"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = var.devops-vpc-id
  stickiness {
    type           = "lb_cookie"
    cookie_duration = 3600
    enabled        = true
  }
  tags = {
    product = "NodeJs"
    application = var.application
    environment = var.environment
  }
}
resource "aws_lb_listener" "devops-alb-listener" {
  load_balancer_arn = var.devops-nodejs-instances-alb-arn
  protocol          = "HTTP"
  port              = 80
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.devops-nodejs-instances-target-group.arn
  }
}
resource "aws_lb_target_group_attachment" "nodejs-attachment-a" {
  target_group_arn = aws_lb_target_group.devops-nodejs-instances-target-group.arn
  target_id        = var.devops-nodejs-ec2-instance-a-id
}
resource "aws_lb_target_group_attachment" "nodejs-attachment-b" {
  target_group_arn = aws_lb_target_group.devops-nodejs-instances-target-group.arn
  target_id        = var.devops-nodejs-ec2-instance-b-id
}