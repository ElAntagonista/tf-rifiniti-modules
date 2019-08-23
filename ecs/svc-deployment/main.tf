locals {
  service_name = "${var.app_name}_service"
  task_name    = "${var.app_name}_task"
}

# Create the security groups for the ecs_tasks
# Ingress only from the alb egress from anywhere
resource "aws_security_group" "ecs_tasks" {
  name        = "${var.app_name}tasks"
  description = "allow inbound access from the ALB only"
  vpc_id      = "${var.vpc_id}"

  ingress {
    protocol        = "tcp"
    from_port       = "${var.app_port}"
    to_port         = "${var.app_port}"
    security_groups = "${list(var.alb_security_group)}"
  }
  
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Create a target group for the service
resource "aws_alb_target_group" "default" {
  name        = "${var.app_name}lbtg"
  port        = "${var.app_port}"
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "${var.vpc_id}"
}

# Create an alb_listener_rule and attach it to the provided alb listener
resource "aws_alb_listener_rule" "default" {
  listener_arn = "${var.alb_http_listener_arn}"
  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.default.arn}"
  }
  condition {
    field  = "${var.lb_rule_conditions_field}"
    values = "${var.lb_rule_conditions_values}"
  }
}

# Create the ecs service
resource "aws_ecs_service" "app" {
  name            = "${local.service_name}"
  cluster         = "${var.ecs_cluster_id}"
  task_definition = "${aws_ecs_task_definition.app.arn}"
  desired_count   = "${var.task_count}"
  launch_type     = "FARGATE"


  network_configuration {
    security_groups = ["${aws_security_group.ecs_tasks.id}"]
    subnets         = "${var.private_subnet_ids}"
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.default.id}"
    container_name   = "${var.app_name}"
    container_port   = "${var.app_port}"
  }
}

# Create the ECS task
resource "aws_ecs_task_definition" "app" {
  family                   = "${local.task_name}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.fargate_specs["cpu"]}"
  memory                   = "${var.fargate_specs["memory"]}"
  execution_role_arn = "${var.task_execution_role_arn}"
  
  container_definitions = <<DEFINITION
[
  { 

    "name": "${var.app_name}",
    "image": "${var.ecr_url}/${var.app_image}:${var.app_image_tag}",
    "cpu": ${var.fargate_specs["cpu"]},
    "memory": ${var.fargate_specs["memory"]},
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${var.app_port},
        "hostPort": ${var.app_port}
      }
    ]
  }
]
DEFINITION
}



