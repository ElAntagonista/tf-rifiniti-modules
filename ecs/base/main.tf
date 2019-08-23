terraform {
  required_version = "> 0.12.0"
  required_providers {
    aws = ">= 2.20.0"
  }
}

#Security groups for ALB
resource "aws_security_group" "lb" {
  name        = "default-lb-tfrifiniti"
  description = "Controls access to ALB"
  vpc_id      = "${var.vpc_id}"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create ALB
resource "aws_alb" "main" {
  name            = "${var.alb_name}"
  subnets         = "${var.public_subnet_ids}"
  security_groups = "${list(aws_security_group.lb.id)}"
}

# Create a default listener on port 80
resource "aws_alb_listener" "default" {
  protocol          = "HTTP"
  port              = "80"
  load_balancer_arn = "${aws_alb.main.arn}"
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "No service could serve your request."
      status_code  = "404"
    }
  }
}

# Create ECS cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.ecs_cluster_name}"
}

# Create the ECR repsositories
resource "aws_ecr_repository" "repos" {
  count = "${length(var.ecr_repo_names)}"
  name = "${var.ecr_repo_names[count.index]}"
}


# Create the task execution role for the tasks
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}


resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.iam_role_name}"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = "${aws_iam_role.ecs_task_execution_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
