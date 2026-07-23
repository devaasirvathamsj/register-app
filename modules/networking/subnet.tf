resource "aws_subnet" "public_subnet_1a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_1a_cidr
    availability_zone = "us-east-1a"

    tags = {
        Name = var.public_subnet_1a_name
    }
  
}

resource "aws_subnet" "private_subnet_1a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_1a_cidr
    availability_zone = "us-east-1a"

    tags = {
        Name = var.private_subnet_1a_name
    }
  
}

resource "aws_subnet" "public_subnet_1b" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_1b_cidr
    availability_zone = "us-east-1b"

    tags = {
        Name = var.public_subnet_1b_name
    }
  
}

resource "aws_subnet" "private_subnet_1b" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_1b_cidr
    availability_zone = "us-east-1b"

    tags = {
        Name = var.private_subnet_1b_name
    }
  
}