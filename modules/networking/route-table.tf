resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = var.public_route_table_name
    }
  
}

resource "aws_route_table_association" "public_rt_association_1a" {
    subnet_id = aws_subnet.public_subnet_1a.id
    route_table_id = aws_route_table.public_rt.id
  
}
resource "aws_route_table_association" "public_rt_association_1b" {
    subnet_id = aws_subnet.public_subnet_1b.id
    route_table_id = aws_route_table.public_rt.id
  
}

resource "aws_route_table" "private_rt_1a" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway.id
    }
    tags = {
        Name = var.private_route_table_1a_name
    }
  
}

resource "aws_route_table_association" "private_rt_association_1a" {
    subnet_id = aws_subnet.private_subnet_1a.id
    route_table_id = aws_route_table.private_rt_1a.id
  
}

resource "aws_route_table" "private_rt_1b" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway.id
    }
    tags = {
        Name = var.private_route_table_1b_name
    }
  
}

resource "aws_route_table_association" "private_rt_association_1b" {
    subnet_id = aws_subnet.private_subnet_1b.id
    route_table_id = aws_route_table.private_rt_1b.id
  
}
