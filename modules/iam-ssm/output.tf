output "ssm_instance_profile_name" {
  description = "Name of the SSM instance profile"
  value       = aws_iam_instance_profile.ssm_instance_profile.name
}

output "ssm_role_name" {
  description = "Name of the SSM role"
  value       = aws_iam_role.ssm_role.name
}

output "ssm_role_arn" {
  description = "ARN of the SSM role"
  value       = aws_iam_role.ssm_role.arn
}

output "ssm_role_policy_attachment_id" {
  description = "ID of the SSM role policy attachment"
  value       = aws_iam_role_policy_attachment.ssm_role_policy_attachment.id
}

output "ecr_policy_attachment_id" {
  description = "ID of the ECR policy attachment (if created)"
  value       = length(aws_iam_role_policy_attachment.ecr_policy_attachment) > 0 ? aws_iam_role_policy_attachment.ecr_policy_attachment[0].id : null
}

output "ecr_policy_attachment_count" {
  description = "Count of the ECR policy attachment"
  value       = length(aws_iam_role_policy_attachment.ecr_policy_attachment)
}
