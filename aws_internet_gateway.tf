resource "aws_internet_gateway" "devops_ec2_gateway" {
  vpc_id = aws_vpc.devops_vpc.id
}

resource "aws_route_table" "devops_routing_table" {
  vpc_id = aws_vpc.devops_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_ec2_gateway.id
  }
}

resource "aws_route_table_association" "devops_routing_association_a" {
  subnet_id      = aws_subnet.devops_subnet_1.id
  route_table_id = aws_route_table.devops_routing_table.id
}
resource "aws_route_table_association" "devops_routing_association_b" {
  subnet_id      = aws_subnet.devops_subnet_2.id
  route_table_id = aws_route_table.devops_routing_table.id
}
resource "aws_route_table_association" "shared_services_routing_association" {
  subnet_id      = aws_subnet.shared_services_subnet.id
  route_table_id = aws_route_table.devops_routing_table.id
}
