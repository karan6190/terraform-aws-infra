## provisioning ig and nat

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "internet-gateway"
    purpose = "to get internet connectivity to public subnets"
  }
}

resource "aws_eip" "ip-1" {
}

resource "aws_eip" "ip-2" {
  
}

resource "aws_nat_gateway" "nat-1" {
  allocation_id = aws_eip.ip-1.id
  subnet_id     = aws_subnet.public-subnet-1

  tags = {
    Name = "gw NAT 1"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "nat-2" {
  allocation_id = aws_eip.ip-2.id
  subnet_id     = aws_subnet.public-subnet-2

  tags = {
    Name = "gw NAT 2"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}