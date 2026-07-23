resource "aws_eip" "nat_eip" {
    domain = "vpc"
    tags = {
        Name = "nat-eip"
    }

}

resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public_subnet_1a.id
    tags = {
        Name = var.nat_gateway_name
    }

    depends_on = [aws_internet_gateway.igw]
  
}