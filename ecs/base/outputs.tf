output "task_execution_role_arn" {
  description = "The execution role used by the ECS task"
  value       = "${aws_iam_role.ecs_task_execution_role.arn}"
}

output "ecs_cluster_id" {
  description = "The id of the ECS cluster"
  value = "${aws_ecs_cluster.main.id}"
}

output "alb_domain_name" {
  description = "The alb domain name"
  value       = "${aws_alb.main.dns_name}"
}

output "alb_sg_id" {
  description = "The service group id of the alb"
  value = "${aws_security_group.lb.id}"
}

output "alb_listener_arn" {
  description = "The arn of the alb listener"
  value = "${aws_alb_listener.default.arn}"
}

output "ecr_base_url" {
  description = "The base url for the ECR"
  value = "${element(split("/",element(aws_ecr_repository.repos.*.repository_url,0)),0)}"
} 
