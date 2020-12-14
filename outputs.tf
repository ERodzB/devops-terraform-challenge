output "ansible-ip-address" {
  value = module.ansible-instance.ansible-ip-address
}
output "devops-nodejs-instances-alb-dns"{
    value = module.application-load-balancer.devops-nodejs-instances-alb-dns
}