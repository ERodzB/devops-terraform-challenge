resource "aws_internet_gateway" "devops-ec2-internet-gateway" {
  vpc_id = var.devops-main-vpc-id
  tags = {
    product     = "DevOps"
    application = var.application
    environment = var.environment
  }
}

resource "aws_route_table" "devops-routing-table" {
  vpc_id = var.devops-main-vpc-id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops-ec2-internet-gateway.id
  }
}

resource "aws_route_table_association" "devops-routing-association-a" {
  subnet_id      = var.devops-public-subnet-a-id
  route_table_id = aws_route_table.devops-routing-table.id
}
resource "aws_route_table_association" "devops-routing-association-b" {
  subnet_id      = var.devops-public-subnet-b-id
  route_table_id = aws_route_table.devops-routing-table.id
}
resource "aws_route_table_association" "shared_services_routing_association" {
  subnet_id      = var.shared-services-subnet-id
  route_table_id = aws_route_table.devops-routing-table.id
}
