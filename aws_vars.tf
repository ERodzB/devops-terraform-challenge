variable "AWS_PROVIDER" {
  type = map(string)
  default = {
    region     = "us-east-1"
    access_key = "yourIAMUserAccesKey"
    secret_key = "yourIAMUserSecretKey"
  }
}

variable "AWS_KEY_PAIR" {
  type = map(string)
  default = {
    public_key  = "key_pairs/devops.pub"
    private_key = "key_pairs/devops"
  }
}