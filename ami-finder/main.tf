data "aws_ami" "amazon-linux-2-server-ami"{
  most_recent = true
  owners = ["amazon"]
  
  filter {
    name = "name"
    values = ["amzn2*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "state"
    values = ["available"]
  }
}
data "aws_ami" "ubuntu-server-ami"{
  most_recent = true
  owners = ["amazon"]
  
  filter {
    name = "name"
    values = ["Ubuntu*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "state"
    values = ["available"]
  }
}