resource "aws_key_pair" "server-key-pair" {
  key_name   = var.key-name
  public_key = file("ssh-keys/${var.public-key-name}")
}