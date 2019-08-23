variable "vpc_cidr_block" {
  description = "CIDR block for the vpc"
  default     = "172.17.0.0/16"
  type = "string"
}

variable "az_count" {
  description = "Number of Availability zones"
  default     = "2"
}

variable "enable_vpc_dns_hostname" {
  description = "Boolean flag to enable hostnames in vpc"
  default     = true
}
variable "enable_vpc_dns" {
  description = "Boolean flag to enable dns in VPC"
  default     = true
}

variable "create_ecr_vpc_endpoint" {
  description = "Boolean flag to enable the creation of ECR vpc endpoints"
  default = true
}


