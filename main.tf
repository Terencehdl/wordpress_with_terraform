provider "aws" {
  region     = "eu-west-3"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "vpc" {
  source = "./modules/vpc"
  
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./modules/ec2"
  evaluation_public_subnet_a_id = module.vpc.evaluation_public_subnet_a_id
  evaluation_public_subnet_b_id = module.vpc.evaluation_public_subnet_b_id
  wordpress_subnet_a_id = module.vpc.wordpress_subnet_a_id
  wordpress_subnet_b_id = module.vpc.wordpress_subnet_b_id
  sg_bastion_id = module.security.sg_bastion_id
  sg_wordpress_id = module.security.sg_wordpress_id
}

module "db_instance" {
  source = "./modules/db_instance"
  evaluation_public_subnet_a_id = module.vpc.evaluation_public_subnet_a_id
  evaluation_public_subnet_b_id = module.vpc.evaluation_public_subnet_b_id
}

module "alb" {
  source = "./modules/alb"
  sg_wordpress_lb_id = module.security.sg_wordpress_lb_id
  evaluation_public_subnet_a_id = module.vpc.evaluation_public_subnet_a_id
  evaluation_public_subnet_b_id = module.vpc.evaluation_public_subnet_b_id
  vpc_id = module.vpc.vpc_id
  wordpress_instance_a_id = module.ec2.wordpress_instance_a_id
  wordpress_instance_b_id = module.ec2.wordpress_instance_b_id
}

module "autoscaling" {
  source = "./modules/autoscaling"
  evaluation_public_subnet_a_id = module.vpc.evaluation_public_subnet_a_id
  evaluation_public_subnet_b_id = module.vpc.evaluation_public_subnet_b_id
}
