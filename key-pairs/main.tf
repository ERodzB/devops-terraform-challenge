resource "aws_key_pair" "devops-ec2-nodejs-key-pair" {
  key_name   = "${var.nodejs-key-name}"
  public_key = file("ssh-keys/${var.nodejs-public-key-name}")
}
resource "aws_key_pair" "devops-ec2-ansible-key-pair" {
  key_name   = "${var.ansible-key-name}"
  public_key = file("ssh-keys/${var.ansible-public-key-name}")
}