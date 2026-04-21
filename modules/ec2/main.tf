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

# EC2 Instance
resource "aws_instance" "ec2" {
  ami           = var.ami_id

  # ✅ WORKS IN ALL ACCOUNTS
  instance_type = "t3.micro"

  subnet_id = data.aws_subnets.default.ids[0]

  tags = {
    Name        = "${var.project_name}-${var.environment}-ec2"
    Environment = var.environment
    Project     = var.project_name
  }
}