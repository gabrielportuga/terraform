
module "s3_bucket" {
  source = "../../../../modules/s3-module"

  bucket_name            = "tripsner-test-bucket"
  environment            = var.environment
  acl                    = "private"
  versioning_enabled     = true
}