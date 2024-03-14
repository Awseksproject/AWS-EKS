module "vpc" {
source = "./Modules/VPC"
tags = "tessolve"
instance_tenancy = "default"
vpc_cidr = "10.0.0.0/16"
access_ip = "0.0.0.0/0"
public_sn_count = 2
public_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
map_public_ip_on_launch = true
rt_route_cidr_block = "0.0.0.0/0"
}
module "eks" {
source = "./Modules/EKS"
aws_public_subnet = module.vpc.aws_public_subnet
vpc_id = module.vpc.vpc_id
cluster_name = "tessolve-eks"
endpoint_public_access = true
endpoint_private_access = false
public_access_cidrs = ["0.0.0.0/0"]
node_group_name = "tessolve"
scaling_desired_size = 2
scaling_max_size = 2
scaling_min_size = 2
instance_types = ["t2.small"]
key_pair = "demo"
}
module "ECR" {
source = "./Modules/ECR"
ecrname = "tessolve-ecr"
}
module "Route53" {
source = "./Modules/Route53"
root_domain_name = "helloworld.info"
}
module "rds_instance" {
  source = "./Modules/AmazonRDS"
  allocated_storage     = 10
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
 
}

