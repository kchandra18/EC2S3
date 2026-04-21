variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Terraform state bucket name"
  type        = string
  default     = "ec2s3-terraform-state-dinesh-001"
}

variable "dynamodb_table" {
  description = "Terraform lock table name"
  type        = string
  default     = "ec2s3-terraform-lock"
}