variable "vpc_id" {
 description = "Id of the the vpc"
}

variable "task_execution_role_arn" {
 description = "The execution role that should be used by the task."
}

variable "ecs_cluster_id" {
  description = "The id of the ECS cluster"
}

variable "alb_http_listener_arn" {
  description = "The id of the Load balancer"
}

variable "private_subnet_ids" {
  description = "Ids of the "
}

variable "app_name" {
  description = "Name of the ECS service to be deployed"
}


variable "app_port" {
  description = "The port that the app would be listening on"
}

variable "app_image" {
 description = "Image name for the task. Should correspond to a ECR repository"
 
}

variable "app_image_tag" {
  description = "Image tag"
  default = "latest"  
}

variable "fargate_specs" {
  description = "Container cpu and memory specs for the task and container definitions"
  type = "map"
  default = {
      cpu = 256
      memory = 512
  }
}

variable "task_count" {
  default = "1"
}

variable "lb_rule_conditions_field" {
  description = "Condition field for the lb_rule"
  default     = "path-pattern"
}

variable "lb_rule_conditions_values" {
  description = "Condition values for the lb_rule"
  type        = "list"
  default     = ["/"]
}

variable "ecr_url" {
  description = "The base url of the ECR registry"
}

variable "alb_security_group" {
  description = "The id of the ALB security group"
}



