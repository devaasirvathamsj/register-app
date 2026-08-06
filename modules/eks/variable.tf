variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "register-app-cluster"
}

variable "vpc_id" {
  description = "VPC ID where EKS will be created"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for EKS"
  type        = list(string)
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.small"
}

variable "desired_node_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 3
}