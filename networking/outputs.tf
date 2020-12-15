output "devops-vpc-id" {
  value = aws_vpc.devops-main-vpc.id
}
output "devops-shared-services-subnet-id" {
  value = aws_subnet.devops-shared-services-subnet.id
}
output "devops-public-subnet-a-id" {
  value = aws_subnet.devops-public-subnet-a.id
}
output "devops-public-subnet-b-id" {
  value = aws_subnet.devops-public-subnet-b.id
}