resource "aws_key_pair" "devops-ec2-nodejs-key-pair" {
  key_name   = "${var.nodejs-key-name}-ec2"
  public_key = file("ssh-keys/${var.nodejs-key-name}.pub")
}
resource "aws_key_pair" "devops-ec2-ansible-key-pair" {
  key_name   = "${var.ansible-key-name}-ec2"
  public_key = file("ssh-keys/${var.ansible-key-name}.pub")
}