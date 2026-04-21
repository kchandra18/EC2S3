resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.app_bucket.id

  rule {
    id     = "log"
    status = "Enabled"

    expiration {
      days = 90
    }

    # ✅ FIX (abort incomplete uploads)
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}