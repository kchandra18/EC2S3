output "bucket_name" {
  description = "Existing S3 bucket used for Terraform state"
  value       = data.aws_s3_bucket.tf_state.bucket
}

output "dynamodb_table" {
  description = "Existing DynamoDB table used for locking"
  value       = data.aws_dynamodb_table.tf_lock.name
}