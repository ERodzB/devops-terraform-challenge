resource "aws_lb_target_group" "devops_ec2_target_group" {
  name     = "devopsEc2TargetGroup"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.devops_vpc.id
  stickiness {
    type           = "lb_cookie"
    cookie_duration = 3600
    enabled        = true
  }

}

resource "aws_lb_target_group_attachment" "ec2Instance1" {
  target_group_arn = aws_lb_target_group.devops_ec2_target_group.arn
  target_id        = aws_instance.devops_ec2_instance.id
}
resource "aws_lb_target_group_attachment" "ec2Instance2" {
  target_group_arn = aws_lb_target_group.devops_ec2_target_group.arn
  target_id        = aws_instance.devops_ec2_instance2.id
}