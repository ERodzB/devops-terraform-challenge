
resource "aws_instance" "ec2-instance" {
  ami                    = var.server-ami-id
  instance_type          = var.instance-type
  key_name               = var.key-pair-name
  vpc_security_group_ids = [var.ec2-security-group]
  subnet_id              = var.ec2-subnet-id
  tags = {
    environment = var.environment
    application = var.application
    product     = var.product
  }
}

