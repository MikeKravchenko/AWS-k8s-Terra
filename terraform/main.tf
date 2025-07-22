provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      "flask-app-tag" = "true"
    }
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  name    = "flask-app-vpc"
  cidr    = "10.0.0.0/20"
  azs     = ["us-east-1a", "us-east-1b"]
  public_subnets = ["10.0.0.0/24", "10.0.1.0/24"]
  map_public_ip_on_launch = true
  enable_nat_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "flask-app-tag" = "true"
  }
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "flask-app-cluster"
  cluster_version = "1.31"
  cluster_endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true
  subnet_ids      = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id
  tags = {
    "flask-app-tag" = "true"
  }

  eks_managed_node_groups = {
    flask-app-nodes = {
      desired_capacity = 1
      max_capacity     = 1
      min_capacity     = 1
      instance_types = ["t3.small"]
      tags = {
        "flask-app-tag" = "true"
      }
    }
  }
}