resource "aws_s3_bucket" "tf_state" {
  bucket = var.bucket_name

  force_destroy = false

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "bootstrap"
  }
}