output "s3_bucket_domain_name" {
  value = "${aws_s3_bucket.tf_state_storage_s3.bucket_domain_name}"
}

output "s3_bucket_regional_domain_name" {
   value = "${aws_s3_bucket.tf_state_storage_s3.bucket_regional_domain_name}"
}