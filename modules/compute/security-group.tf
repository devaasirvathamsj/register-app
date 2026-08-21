resource "aws_security_group" "jenkins_master_sg" {
    name        = var.sg_name_a
    description = var.sg_desc_a
    vpc_id      = var.vpc_id 

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
        from_port       = 9000
        to_port         = 9000
        protocol        = "tcp"
        cidr_blocks     = ["10.0.0.0/16"]
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

resource "aws_security_group_rule" "master_ingress_from_sonarqube" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.jenkins_master_sg.id
  source_security_group_id = aws_security_group.sonarqube_server_sg.id
}

resource "aws_security_group_rule" "master_ingress_from_agent" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.jenkins_master_sg.id
  source_security_group_id = aws_security_group.jenkins_agent_sg.id
}

resource "aws_security_group_rule" "agent_ingress_ssh_from_master" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.jenkins_agent_sg.id
  source_security_group_id = aws_security_group.jenkins_master_sg.id
}