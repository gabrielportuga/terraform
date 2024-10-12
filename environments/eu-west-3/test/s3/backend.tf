provider "aws" {
  region = var.region

  assume_role {
    role_arn = var.role_arn
  }
}

terraform {
   backend "s3" {
    bucket         = "${var.project}-${var.region}-${var.environment}-tfstate-bucket"
    key            = "${var.region}/${var.environment}/${var.functional_resource}/terraform.tfstate"
    region         = var.region
    dynamodb_table = "${var.project}-tfstate-locking"
    encrypt        = true  # Ensures the state is encrypted at rest in S3.
    role_arn       = var.role_arn
  }
}