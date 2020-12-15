output "devops-nodejs-instances-alb-dns" {
  value = aws_lb.devops-nodejs-instances-alb.dns_name
}
output "devops-nodejs-instances-target-group-arn" {
    value = module.target-groups.devops-nodejs-instances-target-group-arn
}