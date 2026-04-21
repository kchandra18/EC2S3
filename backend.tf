terraform {
  backend "s3" {
    bucket         = "ec2s3-terraform-state-dinesh-001"  # CHANGE THIS UNIQUE
    key            = "ec2s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ec2s3-terraform-lock"
    encrypt        = true
  }
}