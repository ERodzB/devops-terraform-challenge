resource "aws_lb" "devops_alb" {
  name               = "devopsLoadBalancer"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.devops_subnet_1.id, aws_subnet.devops_subnet_2.id]
  security_groups    = [aws_security_group.devops_alb_security_group.id]
}

resource "aws_lb_listener" "devops_alb_listener" {
  load_balancer_arn = aws_lb.devops_alb.arn
  protocol          = "HTTP"
  port              = 80
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.devops_ec2_target_group.arn
  }

}

output "alb_dns" {
  value = aws_lb.devops_alb.dns_name
}