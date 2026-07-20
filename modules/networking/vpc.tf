resource "aws_vpc" "demo_vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        name = var.vpc_name
    }
}