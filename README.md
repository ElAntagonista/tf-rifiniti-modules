# tf-rifiniti-modules

# About
This repository contains terraform modules used for creating a production ready AWS Fargate solution.

# Modules list
- [terraform-aws-rs](##terraform-aws-rs)
- [vpc](##vpc)
- [ecs-base](##ecs-base)
- [svc-deployment](##svc-deployment)
# Modules

## terraform-aws-rs
Creates the necesery resources for terraform remote state and locking
## vpc
Creates the foundational resrouces for a VPC enviornment:
- VPC
- public_subnets
- private_subnets
- routing
- VPC endpoints (S3,ECR)

## ecs-base
Creates the foundational resources for the deployment of ECS services:
- ALB
- ALB security group
- ALB default http listener
- ECS cluster
- ECR repositories
- IAM task execution role

## svc-deployment
Creates the main resources for the deployment of an ECS service :
- ECS task definition
- ECS service definition
- ALB target group
- ALB listener rule 
- SG for the tasks 




