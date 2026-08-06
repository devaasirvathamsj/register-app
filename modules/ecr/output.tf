output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.register_app.repository_url
  
}