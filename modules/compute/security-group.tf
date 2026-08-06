resource "aws_security_group" "jenkins_master_sg" {
    name        = var.sg_name_a
    description = var.sg_desc_a
    vpc_id      = var.vpc_id   

    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = var.sg_name_a
    }
}

resource "aws_security_group" "jenkins_agent_sg" {
    name        = var.sg_name_b
    description = var.sg_desc_b
    vpc_id      = var.vpc_id   

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        security_groups = [aws_security_group.jenkins_master_sg.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = var.sg_name_b
    }
}

resource "aws_security_group" "sonarqube_server_sg" {
    name        = var.sg_name_c
    description = var.sg_desc_c
    vpc_id      = var.vpc_id   

    ingress {
        from_port   = 9000
        to_port     = 9000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = var.sg_name_c
    }
}