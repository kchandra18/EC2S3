provider "aws" {
  region = var.aws_region
}

# ==========================================
# Use EXISTING S3 Bucket (Terraform State)
# ==========================================
data "aws_s3_bucket" "tf_state" {
  bucket = var.bucket_name
}

# ==========================================
# Use EXISTING DynamoDB Table (State Lock)
# ==========================================
data "aws_dynamodb_table" "tf_lock" {
  name = var.dynamodb_table
}