output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = module.ecr.ecr_repository_url
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

#output "eks_cluster_name" {
 # description = "EKS cluster name"
  #value       = module.eks.cluster_name
#}

#output "eks_cluster_endpoint" {
# description = "EKS cluster API endpoint"
# value       = module.eks.cluster_endpoint
#}

output "jenkins_master_role_arn" {
  description = "IAM role ARN for Jenkins Master"
  value       = module.iam_ssm_master.ssm_role_arn
}

output "jenkins_agent_role_arn" {
  description = "IAM role ARN for Jenkins Agent"
  value       = module.iam_ssm_agent.ssm_role_arn
}

output "sonarqube_role_arn" {
  description = "IAM role ARN for SonarQube"
  value       = module.iam_ssm_sonarqube.ssm_role_arn
}

output "jenkins_master_instance_id" {
  value = module.compute.jenkins_master_instance_id
}

output "jenkins_agent_instance_id" {
  value = module.compute.jenkins_agent_instance_id
}

output "sonarqube_instance_id" {
  value = module.compute.sonarqube_instance_id
}