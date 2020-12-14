output "devops-ec2-nodejs-key-pair" {
    value = aws_key_pair.devops-ec2-nodejs-key-pair.key_name
}
output "devops-ec2-ansible-key-pair" {
    value = aws_key_pair.devops-ec2-ansible-key-pair.key_name
}