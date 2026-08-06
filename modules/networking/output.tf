output "vpc_id" {
    description = "The ID of the VPC"
    value = aws_vpc.vpc.id
  
}
    
output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [aws_subnet.private_subnet_1a.id, aws_subnet.private_subnet_1b.id]
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1b.id]
}

output "eip_id" {
    description = "The EIP ID"
    value = aws_eip.nat_eip.id
  
}

output "nat_gateway_id" {
    description = "The NAT Gateway ID"
    value = aws_nat_gateway.nat_gateway.id
  
}

output "internet_gateway_id" {
    description = "The Internet Gateway ID"
    value = aws_internet_gateway.igw.id
  
}
