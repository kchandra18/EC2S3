module "ec2" {
  source = "./modules/ec2"

  ami_id        = var.ami_id
  instance_type = var.instance_type
  environment   = var.environment
  project_name  = var.project_name
}

module "s3" {
  source = "./modules/s3"

  bucket_name  = var.s3_bucket_name
  environment  = var.environment
  project_name = var.project_name
}