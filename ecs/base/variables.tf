variable "vpc_id" {
  description = "The id of the VPC"
}

variable "alb_name" {
  description = "The name of the ALB"
}

variable "ecr_repo_names" {
  description = "The names of the ECR repos to be created"
  type = "list"
}

variable "iam_role_name" {
  description = "Name of the task execution IAM role"
  default = "rifiniti-ecs"
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
}

variable "public_subnet_ids" {
  description = "The subnet ids that the ALB should use"
  type        = "list"
}

variable "alb_security_groups" {
  description = "Optional security groups to be provided"
  type        = "list"
  default     = []
}
