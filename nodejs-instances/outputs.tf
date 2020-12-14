output "devops-nodejs-ec2-instance-a-id" {
  value = aws_instance.devops-nodejs-ec2-instance-a.id
}

output "devops-nodejs-ec2-instance-b-id" {
  value = aws_instance.devops-nodejs-ec2-instance-b.id
}

output "devops-nodejs-ec2-instance-a-private-ip" {
  value = aws_instance.devops-nodejs-ec2-instance-a.private_ip
}

output "devops-nodejs-ec2-instance-b-private-ip" {
  value = aws_instance.devops-nodejs-ec2-instance-b.private_ip
}