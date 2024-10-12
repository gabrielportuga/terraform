provider "aws" {
  region = var.region

  assume_role {
    role_arn = var.role_arn
  }
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

# Create the S3 Bucket
resource "aws_s3_bucket" "tfstate-bucket" {
  bucket = "${var.project}-${var.region}-${var.environment}-tfstate-bucket"

  tags = {
    Name        = "${var.project}-${var.region}-${var.environment}-tfstate-bucket"
    Environment = var.environment
  }
}

# Enable versioning for the bucket
resource "aws_s3_bucket_versioning" "s3-versioning" {
  bucket = aws_s3_bucket.tfstate-bucket.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

# Block all public access for the bucket
resource "aws_s3_bucket_public_access_block" "s3-public-access" {
  bucket = aws_s3_bucket.tfstate-bucket.bucket

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}


# Enable default encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "s3-default_encryption" {
  bucket = aws_s3_bucket.tfstate-bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "tfstate-locking" {
  name         = "${var.project}-tfstate-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  deletion_protection_enabled = true

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "${var.project}-tfstate-locking"
    Environment = var.environment
  }
}