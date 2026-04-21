# =========================
# S3 Bucket
# =========================

# checkov:skip=CKV_AWS_144 "Replication not required for this project"
# checkov:skip=CKV2_AWS_62 "Event notifications not required"
# checkov:skip=CKV_AWS_18 "Access logging requires separate logging bucket"
# checkov:skip=CKV_AWS_145 "Using AES256 encryption instead of KMS"

resource "aws_s3_bucket" "app_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "${var.project_name}-${var.environment}-bucket"
    Environment = var.environment
    Project     = var.project_name
  }
}

# =========================
# Encryption (AES256)
# =========================
resource "aws_s3_bucket_server_side_encryption_configuration" "enc" {
  bucket = aws_s3_bucket.app_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# =========================
# Versioning
# =========================
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.app_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# =========================
# Public Access Block
# =========================
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.app_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# =========================
# Lifecycle Configuration
# =========================
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.app_bucket.id

  rule {
    id     = "lifecycle-rule"
    status = "Enabled"

    expiration {
      days = 90
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}