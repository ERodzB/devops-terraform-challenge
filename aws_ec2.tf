resource "aws_instance" "devops" {
  ami           = "ami-099e921e69356cf89"
  instance_type = "t2.micro"
}