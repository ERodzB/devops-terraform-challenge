output "ansible_ip_address" {
  value = aws_instance.devops-ansible-ec2-instance.public_ip
}