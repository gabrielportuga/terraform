output "s3_bucket_arn" {
  value       = aws_s3_bucket.tfstate-bucket.bucket
  description = "The ARN of the S3 bucket for tfstate"
}
output "dynamodb_table_name" {
  value       = aws_dynamodb_table.tfstate-locking.name
  description = "The name of the DynamoDB table with tfstate lock"
}