resource "aws_instance" "jenkins_master" {
  ami                     = var.ec2_ami
  instance_type           = var.ec2_type_for_jenkins_master_and_sonarqube
  vpc_security_group_ids  = [aws_security_group.jenkins_master_sg.id]
  subnet_id               = var.private_subnet_id_1a
  iam_instance_profile    = var.jenkins_master_iam_instance_profile
  user_data_replace_on_change  = true

  user_data = templatefile("${path.module}/scripts/jenkins-master.sh.tpl", {
    public_key = tls_private_key.jenkins_ssh.public_key_openssh
  })

  root_block_device {
    volume_size = var.ec2_volume_size
    volume_type = var.ec2_volume_type
    encrypted   = var.ec2_volume_encrypted
  }

  tags = { Name = var.ec2_name_a }
}

resource "aws_instance" "jenkins_agent" {
  ami                     = var.ec2_ami
  instance_type           = var.ec2_type
  vpc_security_group_ids  = [aws_security_group.jenkins_agent_sg.id]
  subnet_id               = var.private_subnet_id_1b
  iam_instance_profile    = var.jenkins_agent_iam_instance_profile
  user_data_replace_on_change  = true

  user_data = templatefile("${path.module}/scripts/jenkins-agent.sh.tpl", {
    public_key = tls_private_key.jenkins_ssh.public_key_openssh
  })

  root_block_device {
    volume_size = var.ec2_volume_size
    volume_type = var.ec2_volume_type
    encrypted   = var.ec2_volume_encrypted
  }

  tags = { Name = var.ec2_name_b }
}

resource "aws_instance" "sonarqube_server" {
  ami                     = var.ec2_ami
  instance_type           = var.ec2_type_sonarqube
  vpc_security_group_ids  = [aws_security_group.sonarqube_server_sg.id]
  subnet_id               = var.private_subnet_id_1a
  iam_instance_profile    = var.sonarqube_iam_instance_profile
  user_data_replace_on_change  = true

  user_data = templatefile("${path.module}/scripts/sonarqube.sh.tpl", {
    public_key = tls_private_key.jenkins_ssh.public_key_openssh
  })

  root_block_device {
    volume_size = var.ec2_volume_size
    volume_type = var.ec2_volume_type
    encrypted   = var.ec2_volume_encrypted
  }

  tags = { Name = var.ec2_name_c }
}