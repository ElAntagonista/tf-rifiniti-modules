output "vpc_id" {
  description = "The id of the vpc"
  value       = "${aws_vpc.main.id}"
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = "${aws_vpc.main.arn}"
}

output "vpc_main_route_table_id" {
  description = "Vpc's main route table"
  value       = "${aws_vpc.main.main_route_table_id}"
}

output "public_subnet_ids" {
  description = "Public subnet(s) id"
  value       = "${aws_subnet.public.*.id}"
}

output "private_subnet_ids" {
  description = "Private subnet(s) id"
  value       = "${aws_subnet.private.*.id}"
}

output "public_subnet_cidr_blocks" {
  description = "Public subnet(s) cidr block(s)"
  value       = "${aws_subnet.public.*.cidr_block}"
}

output "private_subnet_cidr_blocks" {
  description = "Private subnet(s) cidr block(s)"
  value       = "${aws_subnet.private.*.cidr_block}"
}

output "ecr_vpc_ept_sg_ids" {
  description = "ECR vpc endpoint Security group id(s)"
  value       = "${aws_vpc_endpoint.ecr[0].security_group_ids}"
}

output "ecr_vpc_ept_id" {
  description = "ECR id"
  value       = "${aws_vpc_endpoint.ecr[0].id}"
}
