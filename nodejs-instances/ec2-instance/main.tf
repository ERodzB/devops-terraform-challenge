
data "template_file" "node-script" {
  template = file("scripts/nodejs.sh")
  vars = {
    "ansible-private-ip-address" = var.ansible-private-ip-address
    "ansible-key-name"           = var.ansible-private-key-name
    "nodejs-key-name"            = var.nodejs-private-key-name
    "ssh-key"                    = filebase64("ssh-keys/${var.ansible-private-key-name}")
  }
}
resource "aws_instance" "ec2-instance" {
  ami                    = var.server-ami-id
  instance_type          = var.instance-type
  key_name               = var.key-pair-name
  vpc_security_group_ids = [var.ec2-security-group]
  subnet_id              = var.ec2-subnet-id
  user_data              = data.template_file.node-script.rendered
  tags = {
    environment = var.environment
    application = var.application
    product     = var.product
  }
}

