output "jenkins_master_instance_id" {
  description = "ID of the Jenkins master EC2 instance"
  value       = aws_instance.jenkins_master.id
  
}

output "jenkins_agent_instance_id" {
  description = "ID of the Jenkins agent EC2 instance"
  value       = aws_instance.jenkins_agent.id
}

output "sonarqube_instance_id" {
  description = "ID of the SonarQube EC2 instance"
  value       = aws_instance.sonarqube_server.id
}