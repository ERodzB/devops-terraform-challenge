data "template_file" "ansible_script" {
  template = file("scripts/ansible.sh")
  vars = {
    "ec2_ip1" = aws_instance.devops_ec2_instance.private_ip
    "ec2_ip2" = aws_instance.devops_ec2_instance2.private_ip
  }
}

resource "aws_instance" "ansible_ec2_instance" {
  ami                    = "ami-04d29b6f966df1537"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.shared_services_security_group.id]
  subnet_id              = aws_subnet.shared_services_subnet.id
  user_data = data.template_file.ansible_script.rendered
  
  provisioner "file" {
    source = "scripts/node.yaml"
    destination = "/tmp/node.yaml"
  }
  provisioner "file" {
    source = "scripts/ping.yaml"
    destination = "/tmp/ping.yaml"
  }
  provisioner "file" {
    source = var.AWS_KEY_PAIR["private_key"]
    destination = "/tmp/devops"
  }
  
  connection {
    host        = aws_instance.ansible_ec2_instance.public_ip
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.AWS_KEY_PAIR["private_key"])
  }
  tags = {
    product = "ansible"
    test = "test"
  }
}

output "ansible_ip_address" {
  value = aws_instance.ansible_ec2_instance.public_ip
}