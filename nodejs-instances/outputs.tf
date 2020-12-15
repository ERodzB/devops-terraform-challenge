output "devops-nodejs-ec2-instance-a-id" {
  value = module.devops-nodejs-ec2-instance-a.ec2-instance-id
}

output "devops-nodejs-ec2-instance-b-id" {
  value = module.devops-nodejs-ec2-instance-b.ec2-instance-id
}

output "devops-nodejs-ec2-instance-a-private-ip" {
  value = module.devops-nodejs-ec2-instance-a.ec2-instance-private-ip
}

output "devops-nodejs-ec2-instance-b-private-ip" {
  value = module.devops-nodejs-ec2-instance-b.ec2-instance-private-ip
}