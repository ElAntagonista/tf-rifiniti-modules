terraform {
  required_version = "> 0.12.0"
  required_providers {
    aws = ">= 2.20.0"
  }
}

# S3 bucket to store terraform state file
resource "aws_s3_bucket" "tf_state_storage_s3" {
  bucket = "${var.s3_bucket_name}"

  lifecycle {
    prevent_destroy = false
  }
  force_destroy = true
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = "${var.s3_tags}"
}

#Dynamodb table used for locking terraform  state file
resource "aws_dynamodb_table" "tf_state_lock" {
  name           = "${var.dynamodb_table_name}"
  hash_key       = "LockID"
  read_capacity  = "${var.dynamodb_rc}"
  write_capacity = "${var.dynamodb_wc}"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = "${var.dynamodb_table_tags}"
}
