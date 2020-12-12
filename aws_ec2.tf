resource "aws_instance" "devops_ec2_instance" {
  ami                    = "ami-099e921e69356cf89"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.devops_ssh.id]
  subnet_id              = aws_subnet.devops_subnet_1.id
}