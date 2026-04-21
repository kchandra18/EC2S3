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

# EC2 Instance (ONLY ONE BLOCK)
resource "aws_instance" "ec2" {
  ami           = var.ami_id
  instance_type = "t2.micro"   # free tier safe

  subnet_id = data.aws_subnets.default.ids[0]

  tags = {
    Name        = "${var.project_name}-${var.environment}-ec2"
    Environment = var.environment
    Project     = var.project_name
  }
}