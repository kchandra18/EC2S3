resource "aws_instance" "ec2" {
  ami           = var.ami_id
  instance_type = "t3.micro"

  ebs_optimized = true   # ✅ FIX

  subnet_id = data.aws_subnets.default.ids[0]

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  monitoring = true

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted = true
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-ec2"
    Environment = var.environment
    Project     = var.project_name
  }
}