output "devops-ec2-nodejs-key-pair" {
    value = aws_key_pair.devops-ec2-nodejs-key-pair.name
}
output "devops-ec2-ansible-key-pair" {
    value = aws_key_pair.devops-ec2-ansible-key-pair.name
}