resource "aws_key_pair" "devops_key" {
  key_name   = "DevOpsKey"
  public_key = file(var.AWS_KEY_PAIR["public_key"])
}