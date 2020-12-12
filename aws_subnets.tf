resource "aws_subnet" "devops_subnet_1" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.AWS_PROVIDER["region"]}a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "devops_subnet_2" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.AWS_PROVIDER["region"]}b"
  map_public_ip_on_launch = true
}