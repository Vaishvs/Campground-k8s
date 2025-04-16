#private subnet for eks cluster and worker node
resource "aws_subnet" "workernode_private_subnet1" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = "172.31.48.0/20"
  map_public_ip_on_launch = false
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "WorkerPrivateSubnet1"
  }
}

resource "aws_subnet" "workernode_private_subnet2" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = "172.31.64.0/20"
  map_public_ip_on_launch = false
  availability_zone       = "ap-south-1b"

  tags = {
    Name = "WorkerPrivateSubnet2"
  }
}

resource "aws_eip" "nat_gateway_eip" {
  tags = {

    Name = "NAT Gateway EIP"

  }

}

#route tables and internet gateway is remaining

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = data.aws_subnet.my_subnet.id


  tags = {
    Name = "gw NAT"
  }


  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [data.aws_internet_gateway.default]
}

resource "aws_route_table" "workernode_rt1" {
  vpc_id = data.aws_vpc.default.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "private-rtable-1"
  }
}

resource "aws_route_table" "workernode_rt2" {
  vpc_id = data.aws_vpc.default.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "private-rtable-2"
  }
}

resource "aws_route_table_association" "workernode_rtassociation1" {
  subnet_id      = aws_subnet.workernode_private_subnet1.id
  route_table_id = aws_route_table.workernode_rt1.id
}

resource "aws_route_table_association" "workernode_rtassociation2" {
  subnet_id      = aws_subnet.workernode_private_subnet2.id
  route_table_id = aws_route_table.workernode_rt2.id
}

## vpc already has existing igw
# resource "aws_internet_gateway" "igw" {  
#   vpc_id = data.aws_vpc.default.id

#   tags= {
#     Name = "Internet Gateway"
#   }
# }

resource "aws_route_table" "igw_rt" { #route table is for public subnet
  vpc_id = data.aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.default.id
  }

  tags = {
    Name = "public-rtable-3"
  }
}


resource "aws_route_table_association" "igw_rtassociation" {
  subnet_id      = data.aws_subnet.my_subnet.id
  route_table_id = aws_route_table.igw_rt.id
}

