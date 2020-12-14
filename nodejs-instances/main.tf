resource "aws_instance" "devops-nodejs-ec2-instance-a" {
  ami                    = "ami-099e921e69356cf89"
  instance_type          = "t2.micro"
  key_name               = var.nodejs-key-pair
  vpc_security_group_ids = [var.devops-ec2-security-group]
  subnet_id              = var.devops-public-subnet-a-id
  tags {
    environment = var.environment
    application = var.application
    product = "nodejs"
  }
}

resource "aws_instance" "devops-nodejs-ec2-instance-b" {
  ami                    = "ami-099e921e69356cf89"
  instance_type          = "t2.micro"
  key_name               = var.nodejs-key-pair
  vpc_security_group_ids = [var.devops-ec2-security-group]
  subnet_id              = var.devops-public-subnet-b-id
  tags {
    environment = var.environment
    application = var.application
    product = "nodejs"
  }
}

