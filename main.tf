module "networking" {
  source = "./modules/networking"
}

module "iam_ssm_master" {
  source        = "./modules/iam-ssm"
  ssm_role_name = "jenkins-master-ssm-role"
}

module "iam_ssm_agent" {
  source            = "./modules/iam-ssm"
  ssm_role_name     = "jenkins-agent-ssm-role"
  attach_ecr_policy = true
}

module "iam_ssm_sonarqube" {
  source        = "./modules/iam-ssm"
  ssm_role_name = "sonarqube-ssm-role"
}

module "compute" {
  source = "./modules/compute"

  vpc_id                = module.networking.vpc_id
  private_subnet_id_1a  = module.networking.private_subnet_ids[0]
  private_subnet_id_1b  = module.networking.private_subnet_ids[1]

  jenkins_master_iam_instance_profile = module.iam_ssm_master.ssm_instance_profile_name
  jenkins_agent_iam_instance_profile  = module.iam_ssm_agent.ssm_instance_profile_name
  sonarqube_iam_instance_profile      = module.iam_ssm_sonarqube.ssm_instance_profile_name
}

module "eks" {
  source              = "./modules/eks"
  cluster_name        = "register-app-cluster"
  vpc_id              = module.networking.vpc_id
  private_subnet_ids  = module.networking.private_subnet_ids
  node_instance_type  = "t3.small"
  desired_node_count  = 3
}

module "ecr" {
  source = "./modules/ecr"
}