variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16" 
}

variable "vpc_name" {
    description = "The name of the VPC"
    type        = string
    default     = "demo-vpc"
}

variable "availability_zone_1a" {
    description = "Availability zone 1a"
    type        = string
    default     = "us-east-1a"
}

variable "availability_zone_1b" {
    description = "Availability zone 1b"
    type        = string
    default     = "us-east-1b"
}

variable "public_subnet_1a_cidr" {
    description = "Public subnet 1a CIDR"
    type        = string
    default     = "10.0.1.0/24"

}

variable "public_subnet_1a_name" {
    description = "Public subnet 1a name"
    type        = string
    default     = "demo-public-subnet-1a"
  
}

variable "private_subnet_1a_cidr" {
    description = "Private subnet 1a CIDR"
    type        = string
    default     = "10.0.2.0/24"

}

variable "private_subnet_1a_name" {
    description = "Private subnet 1a name"
    type        = string
    default     = "demo-private-subnet-1a"
}

variable "public_subnet_1b_cidr" {
    description = "Public subnet 1b CIDR"
    type        = string
    default     = "10.0.3.0/24"

}

variable "public_subnet_1b_name" {
    description = "Public subnet 1b name"
    type        = string
    default     = "demo-public-subnet-1b"
  
}

variable "private_subnet_1b_cidr" {
    description = "Private subnet 1b CIDR"
    type        = string
    default     = "10.0.4.0/24"

}

variable "private_subnet_1b_name" {
    description = "Private subnet 1b name"
    type        = string
    default     = "demo-private-subnet-1b"
  
}

variable "internet_gateway_name" {
    description = "Internet gateway name"
    type        = string
    default     = "demo-internet-gateway"
  
}

variable "nat_gateway_name" {
    description = "NAT gateway name"
    type        = string
    default     = "demo-nat-gateway"
  
}

variable "public_route_table_name" {
    description = "Public route table name"
    type        = string
    default     = "demo-public-route-table"
    
}

variable "private_route_table_1a_name" {
    description = "Private route table 1a name"
    type        = string
    default     = "demo-private-route-table-1a"
  
}

variable "private_route_table_1b_name" {
    description = "Private route table 1b name"
    type        = string
    default     = "demo-private-route-table-1b"
}
