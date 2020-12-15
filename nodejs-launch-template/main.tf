data "template_file" "nodejs-script" {
  template = file("scripts/nodejs.sh")
  vars = {
    "ansible-private-ip-address" = var.ansible-private-ip-address
  }
}
resource "aws_launch_template" "devops-nodejs-launch-template" {
  name                   = "devops-${var.application}-nodejs-launch-template-${var.environment}"
  image_id               = var.nodejs-server-ami-id
  key_name               = var.nodejs-key-pair
  instance_type          = var.nodejs-instance-type
  vpc_security_group_ids = [var.devops-ec2-security-group]
  user_data              = base64encode(data.template_file.nodejs-script.rendered)
  provisioner "file" {
    source      = "ssh-kes/${var.ansible-private-key}"
    destination = "/tmp"
  }/*
  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("ssh-keys/${var.nodejs-private-key-name}")
  }*/
  tags = {
    product     = "nodejs"
    environment = var.environment
    application = var.application
  }
}

module "nodejs-auto-scaling-group" {
  source = "./nodejs-auto-scaling-group"

  environment = var.environment
  application = var.application

  devops-nodejs-launch-template-name       = aws_launch_template.devops-nodejs-launch-template.name
  devops-public-subnet-a-id                = var.devops-public-subnet-a-id
  devops-public-subnet-b-id                = var.devops-public-subnet-b-id
  devops-nodejs-instances-target-group-arn = var.devops-nodejs-instances-target-group-arn
}
module "nodejs-auto-scaling-policy" {
  source = "./nodejs-auto-scaling-policy"

  environment = var.environment
  application = var.application

  devops-nodejs-auto-scaling-group-name = module.nodejs-auto-scaling-group.devops-nodejs-auto-scaling-group-name
}
module "nodejs-cloudwatch-alarms" {
  source = "./nodejs-cloudwatch-alarms"

  environment = var.environment
  application = var.application

  devops-nodejs-auto-scaling-group-name            = module.nodejs-auto-scaling-group.devops-nodejs-auto-scaling-group-name
  devops-nodejs-add-servers-autoscaling-policy-arn = module.nodejs-auto-scaling-policy.devops-nodejs-add-servers-autoscaling-policy-arn


  devops-nodejs-remove-servers-autoscaling-policy-arn = module.nodejs-auto-scaling-policy.devops-nodejs-remove-servers-autoscaling-policy-arn
}