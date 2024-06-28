Deploying a WordPress Infrastructure with Terraform
Introduction
Hey there! Welcome to my Terraform project for deploying a WordPress website for my new employer's business. This project showcases my skills in building, deploying, and automating a scalable and highly available infrastructure using AWS services and Terraform.

Architecture Overview
Here's a breakdown of the architecture I've set up:

Region: Paris (eu-west-3)
Networking: 1 VPC with 4 subnets (2 private and 2 public)
Each public subnet has a NAT Gateway for internet access to the private subnets
WordPress Servers: Deployed in an Autoscaling Group using t2.micro instances across multiple Availability Zones
Minimum 1 instance, maximum 2 instances per Autoscaling Group
Database: Deployed on db.t3.micro instances across 2 different Availability Zones
Load Balancer: Application Load Balancer (ALB) for high availability
Bastion Host: Provides secure proxy entry point
Bonus: Can be placed in an Autoscaling Group for high availability
Access: HTTP access to the web server on port 80
Bonus: Secure HTTPS access on port 443 (TLS)
Terraform Modules
I've structured the Terraform code into reusable modules for better maintainability and scalability:

Networking Module: Defines the VPC, subnets, NAT Gateways, and route tables.
WordPress Module: Configures the Autoscaling Group, launch configurations, and security groups for the WordPress servers.
Database Module: Sets up the RDS instances and associated resources.
Load Balancer Module: Configures the ALB and associated resources.
Bastion Host Module: Defines the EC2 instance for the bastion host.
Variables Module: Contains variable definitions for the project.
Deployment Instructions
Here's how I deploy the infrastructure:

I clone this repository to my local machine.
I navigate to the directory containing the Terraform files.
I update the terraform.tfvars file with my AWS credentials and any other necessary variables.
I run terraform init to initialize the project.
I run terraform plan to review the execution plan.
I run terraform apply to deploy the infrastructure.
Once deployed, I access the WordPress website using the provided URL.
Testing
Before deployment, I thoroughly test the Terraform code:

I validate the syntax and structure using terraform validate.
I simulate the execution plan using terraform plan to catch any potential issues.
I test the deployment in a staging environment if possible before applying changes in production.
Bonus Features
I've included some additional features:

High Availability: Utilizing Autoscaling Groups for both WordPress servers and the bastion host for improved availability.
Secure Access: Implementing HTTPS access using TLS certificates for enhanced security.
Conclusion
This Terraform project demonstrates a scalable, highly available infrastructure for deploying a WordPress website. By following best practices and modularizing the code, the infrastructure is easily maintainable, reusable, and scalable. Let's go, I'm on fire!