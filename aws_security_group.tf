resource "aws_security_group" "devops_ssh" {
  name        = "devops_ssh"
  description = "Allow ssh to EC2 instances"
  vpc_id      = aws_vpc.devops_vpc.id
  ingress {
    description = "Allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MACHINE_CONFIG["machine_ip"]]
  }
  ingress{
    description = "Allow HTTP traffic from ALB"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.devops_alb_security_group.id]
  } 
  ingress{
    description = "Allow HTTPS traffic from ALB"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    security_groups = [aws_security_group.devops_alb_security_group.id]
  } 
  ingress{
    description = "testing script"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["190.92.58.176/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "devops_alb_security_group" {
  name        = "devops_alb_security_group"
  description = "Allow traffic from http and https"
  vpc_id      = aws_vpc.devops_vpc.id
  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    description = "Allow HTTPS traffic"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}