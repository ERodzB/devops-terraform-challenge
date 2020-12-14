output "devops-ec2-security-group" {
    value = aws_security_group.devops-ec2-security-group.id
}
output "devops-ec2-security-group-arn" {
    value = aws_security_group.devops-ec2-security-group.arn
}
output "devops-alb-security-group" {
    value = aws_security_group.devops-alb-security-group.id
}
output "devops-shared-services-security-group" {
    value = aws_security_group.shared-services-security-group.id
}
