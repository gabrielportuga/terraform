# main.tf
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = merge(
    {
      Name        = var.bucket_name,
      Environment = var.environment
    },
    var.additional_tags
  )
}

resource "aws_s3_bucket_versioning" "this" {
  count  = var.versioning_enabled == true ? 1 : 0
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable default encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "s3-default_encryption" {
  count  = var.use_aes256_encryption ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_logging" "this" {
  count         = var.logging == null ? 0 : 1
  bucket        = aws_s3_bucket.this.id
  target_bucket = var.logging.target_bucket
  target_prefix = var.logging.target_prefix != null ? var.logging.target_prefix : "${aws_s3_bucket.this.id}/"
}