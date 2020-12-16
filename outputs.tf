output "ansible-ip-address" {
  value = module.ansible-instance.ansible-ip-address
}
output "devops-nodejs-instances-alb-dns" {
  value = module.application-load-balancer.devops-nodejs-instances-alb-dns
}

output "devops-nodejs-ec2-instance-a-private-ip" {
  value = module.nodejs-instances.devops-nodejs-ec2-instance-a-private-ip
}

output "devops-nodejs-ec2-instance-b-private-ip" {
  value = module.nodejs-instances.devops-nodejs-ec2-instance-b-private-ip
}
output "devops-nodejs-ec2-instance-a-public-ip" {
  value = module.nodejs-instances.devops-nodejs-ec2-instance-a-public-ip
}

output "devops-nodejs-ec2-instance-b-public-ip" {
  value = module.nodejs-instances.devops-nodejs-ec2-instance-b-public-ip
}