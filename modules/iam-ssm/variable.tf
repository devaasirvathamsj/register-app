variable "ssm_role_name" {
    description = "Name of the SSM role"
    type        = string
    default     = "EC2-ssm-role"
}

variable "attach_ecr_policy" {
  description = "Whether to attach ECR full access policy to this role"
  type        = bool
  default     = false
}