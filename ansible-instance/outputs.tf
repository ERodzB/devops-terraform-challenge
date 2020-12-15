output "ansible-ip-address" {
  value = aws_instance.devops-ansible-ec2-instance.public_ip
}
output "ansible-private-ip-address" {
  value = aws_instance.devops-ansible-ec2-instance.private_ip
}
