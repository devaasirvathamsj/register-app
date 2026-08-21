variable "ec2_name_a" {
    description = "EC2 instance name"
    type = string
    default = "jenkins-master"
  
}

variable "ec2_name_b" {
    description = "EC2 instance name"
    type = string
    default = "jenkins-agent"
  
}

variable "ec2_name_c" {
    description = "EC2 instance name"
    type = string
    default = "sonarqube-server"
  
}

variable "ec2_type_for_jenkins_master_and_sonarqube" {
    description = "EC2 instance type for Jenkins master and SonarQube server"
    type        = string
    default     = "t3.small"   
}
variable "ec2_type_sonarqube" {
    description = "EC2 instance type for SonarQube server"
    type        = string
    default     = "c7i-flex.large"
}

variable "ec2_type" {
    description = "EC2 instance type for Jenkins agent"
    type        = string
    default     = "t3.small"
}

variable "ec2_ami" {
    description = "AMI ID for the Jenkins master instance"
    type        = string
    default     = "ami-0b6d9d3d33ba97d99"
  
}

variable "ec2_volume_size" {
    description = "Volume size for the EC2 instance"
    type        = number
    default     = 20
}

variable "ec2_volume_type" {
    description = "Volume type for the EC2 instance"
    type        = string
    default     = "gp3"
}

variable "ec2_volume_encrypted" {
    description = "Whether the EC2 instance volume should be encrypted"
    type        = bool
    default     = true
}

variable "sg_name_a" {
    description = "Security group name for Jenkins master"
    type        = string
    default     = "jenkins-master-sg"
}

variable "sg_desc_a" {
    description = "Security group description for Jenkins master"
    type        = string
    default     = "Security group for Jenkins master to run jenkins server and allow access to port 8080"
}

variable "sg_name_b" {
    description = "Security group name for Jenkins agent"
    type        = string
    default     = "jenkins-agent-sg"
}

variable "sg_desc_b" {
    description = "Security group description for Jenkins agent"
    type        = string
    default     = "Security group for Jenkins agent"
}

variable "sg_name_c" {
    description = "Security group name for SonarQube server"
    type        = string
    default     = "sonarqube-sg"
}

variable "sg_desc_c" {
    description = "Security group description for SonarQube server"
    type        = string
    default     = "Security group for SonarQube server to run sonarqube and allow access to port 9000"
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_id_1a" {
  type = string
}

variable "private_subnet_id_1b" {
  type = string
}

variable "jenkins_master_iam_instance_profile" {
  type = string
}

variable "jenkins_agent_iam_instance_profile" {
  type = string
}

variable "sonarqube_iam_instance_profile" {
  type = string
}
  