module "devops-nodejs-ec2-instance-a" {
  source = "./ec2-instance"
  server-ami-id                    = var.ubuntu-server-ami-id
  instance-type          = var.instance-type
  key-name               = var.nodejs-key-pair
  ec2-security-group = var.devops-ec2-security-group
  ec2-subnet-id = var.devops-public-subnet-a-id
  product = "nodejs"
  environment = var.application
  application = var.environment
}
module "devops-nodejs-ec2-instance-b" {
  source = "./ec2-instance"
  server-ami-id                    = var.ubuntu-server-ami-id
  instance-type          = var.instance-type
  key-name               = var.nodejs-key-pair
  ec2-security-group = var.devops-ec2-security-group
  ec2-subnet-id = var.devops-public-subnet-b-id
  product = "nodejs"
  environment = var.application
  application = var.environment
}

