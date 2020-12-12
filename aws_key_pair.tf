resource "aws_key_pair" "DevOpsKey" {
    key_name = "DevOpsKey"
    public_key = var.AWS_KEY_PAIR["public_key"]
}