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
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}