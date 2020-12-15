output "ec2-instance-a-id" {
  value = aws_instance.devops-nodejs-ec2-instance-a.id
}
output "ec2-instance-b-public-ip" {
  value = aws_instance.devops-nodejs-ec2-instance-b.public_ip
}
output "ec2-instance-b-private-ip" {
  value = aws_instance.devops-nodejs-ec2-instance-b.private_ip
}