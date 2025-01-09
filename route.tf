## provisioning route tables

resource "aws_route_table" "public-route" {
    vpc_id = aws_vpc.vpc.id

    route = {
        cidr_block = "0.0.0.0/0" ## ALL Traffic
        gateway_id = aws_internet_gateway.gw.id
    }
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-route.id
}

##

resource "aws_route_table" "private-route-1" {
  vpc_id = aws_vpc.vpc.id

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-1.id
  }
}

resource "aws_route_table" "private-route-2" {
  vpc_id = aws_vpc.vpc.id

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-2.id
  }
}

resource "aws_route_table_association" "private-1" {
  subnet_id = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-1.id
}

resource "aws_route_table_association" "private-2" {
  subnet_id = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-2.id
}