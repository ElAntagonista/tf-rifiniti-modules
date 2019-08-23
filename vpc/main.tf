terraform {
  required_version = "> 0.12.0"
  required_providers {
    aws = ">= 2.20.0"
  }
}

locals {
  s3_service_url  = "com.amazonaws.${data.aws_region.current.name}.s3"
  ecr_service_url = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
  cw_service_url  = "com.amazonaws.${data.aws_region.current.name}.logs"
}

# Get avaialable AZs in the current region
data "aws_availability_zones" "available" {
  state = "available"
}

# Get current region
data "aws_region" "current" {

}

resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = "${var.enable_vpc_dns_hostname}"
  enable_dns_support   = "${var.enable_vpc_dns}"
}

# Create public subnets with count equal to az_count
resource "aws_subnet" "public" {
  count                   = "${var.az_count}"
  cidr_block              = "${cidrsubnet(aws_vpc.main.cidr_block, 8, var.az_count + count.index)}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  vpc_id                  = "${aws_vpc.main.id}"
  map_public_ip_on_launch = true
}

# Create an Internet GW for the vpc
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
}

# Route the public subnet traffic through the IGW
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.main.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

# Create private subnets with count equal to az_count
resource "aws_subnet" "private" {
  count             = "${var.az_count}"
  cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  vpc_id            = "${aws_vpc.main.id}"
}

# Create private aws_route_table
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"
}

# Associate explicitly private subnets with the private route table
resource "aws_route_table_association" "private" {
  count          = "${length(aws_subnet.private.*.id)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}

# Create the S3 vpc endpoint needed by the ECR service
resource "aws_vpc_endpoint" "s3" {
  count        = "${var.create_ecr_vpc_endpoint == true ? 1 : 0}"
  vpc_id       = "${aws_vpc.main.id}"
  service_name = "${local.s3_service_url}"
}

# Associate the vpc endpoint with the vpc route table
resource "aws_vpc_endpoint_route_table_association" "s3_rt_association" {
  count           = "${var.create_ecr_vpc_endpoint == true ? 1 : 0}"
  route_table_id  = "${aws_route_table.private.id}"
  vpc_endpoint_id = "${aws_vpc_endpoint.s3[count.index].id}"
}

# Create the security group for the ECR service
resource "aws_security_group" "ecr" {
  
  count = "${var.create_ecr_vpc_endpoint == true ? 1 : 0}"
  vpc_id = "${aws_vpc.main.id}"
  name        = "ecr_security_group"
  description = "Secuirty group for ECR VPC endpoint"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${aws_subnet.private.*.cidr_block}"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${aws_subnet.private.*.cidr_block}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Create ECR endpoint and associate it with the private subnets just created
resource "aws_vpc_endpoint" "ecr" {
  count               = "${var.create_ecr_vpc_endpoint == true ? 1 : 0}"
  vpc_id              = "${aws_vpc.main.id}"
  service_name        = "${local.ecr_service_url}"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = "${aws_subnet.private.*.id}"
  security_group_ids  = "${list(aws_security_group.ecr[count.index].id)}"
}






