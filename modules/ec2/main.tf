# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get subnets
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# IAM Role for EC2
resource "aws_iam_role" "ec2_role" {
  name = "${var.project_name}-${var.environment}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Attach policy
resource "aws_iam_role_policy_attachment" "ec2_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Instance profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-${var.environment}-profile"
  role = aws_iam_role.ec2_role.name
}

# EC2 Instance
resource "aws_instance" "ec2" {
  ami           = var.ami_id
  instance_type = "t3.micro"

  subnet_id = data.aws_subnets.default.ids[0]

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  monitoring = true   # ✅ enable detailed monitoring

  metadata_options {
    http_tokens = "required"   # ✅ IMDSv2 only
  }

  root_block_device {
    encrypted = true   # ✅ encryption
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-ec2"
    Environment = var.environment
    Project     = var.project_name
  }
}