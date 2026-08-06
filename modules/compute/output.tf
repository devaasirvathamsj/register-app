output "ec2_a" {
    description = "The ID of the EC2 instance in subnet 1a"
    value = aws_instance.jenkins_master.id
}

output "ec2_b" {
    description = "The ID of the EC2 instance in subnet 1b"
    value = aws_instance.jenkins_agent.id
}

output "ec2_c" {
    description = "The ID of the SonarQube Server in subnet 1a"
    value = aws_instance.sonarqube_server.id
}

