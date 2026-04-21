variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "environment" {
  type = string
}

variable "project_name" {
  type = string
}

variable "s3_bucket_name" {
  type = string
}