
data "template_file" "ansible-script" {
  template = file("scripts/ansible.sh")
  vars = {
    "ec2_ip1" = var.devops-nodejs-ec2-instance-a-private-ip
    "ec2_ip2" = var.devops-nodejs-ec2-instance-b-private-ip
    "nodejs-key-name" = var.nodejs-private-key-name
  }
}
resource "aws_instance" "devops-ansible-ec2-instance" {
  ami                    = var.amazon-linux-2-server-ami-id
  instance_type          = "t2.micro"
  key_name               = var.devops-ec2-ansible-key-pair
  vpc_security_group_ids = [var.devops-shared-services-security-group]
  subnet_id              = var.devops-shared-services-subnet-id
  user_data              = data.template_file.ansible-script.rendered

  provisioner "file" {
    source      = "scripts/node.yaml"
    destination = "/tmp/node.yaml"
  }
  provisioner "file" {
    source      = "scripts/ping.yaml"
    destination = "/tmp/ping.yaml"
  }
  provisioner "file" {
    source      = "ssh-keys/${var.nodejs-private-key-name}"
    destination = "/tmp/${var.nodejs-private-key-name}"
  }
  connection {
    host        = aws_instance.devops-ansible-ec2-instance.public_ip
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("ssh-keys/${var.ansible-private-key-name}")
  }
  tags = {
    product = "ansible"
    environment = var.environment
    application = var.application
  }
}

