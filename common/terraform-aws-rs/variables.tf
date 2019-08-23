variable "s3_tags" {
  description = "Tags to be set on the S3 bucket"
  type = "map"
  default = {
    Name = "S3 remote state storage"
    Environment = "Production"
  }
}

variable "s3_bucket_name" {
  description = "The bucket name for the S3"
  type = "string"
}

variable "dynamodb_table_name" {
  description = "The name of the dynamo db table"
  type = "string"
}

variable "dynamodb_table_tags" {
  description = "Tags to be set on the dynamodb table"
  type = "map"
  default = {
    Name = "Dynamodb remote state lock"
    Environment = "Production"
  }
}

variable "dynamodb_rc" {
  description = "Dynamodb table read capacity"
  type = "string"
  default = 20
}

variable "dynamodb_wc" {
  description = "Dynamodb table write capacity"
  type = "string"
  default = 20
}