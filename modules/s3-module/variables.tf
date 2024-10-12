# variables.tf
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "The environment (dev, stage, prod) for the S3 bucket"
  type        = string
}

variable "bucket_type" {
  description = "Depending on the bucket type additional policies have to be attached to the bucket. Possible values [data, log, alb-log, vpc-flow-log]"
  default     = "data"
}

variable "acl" {
  description = "The access control list (ACL) for the bucket"
  type        = string
  default     = "private"
}

variable "versioning_enabled" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = true
}

variable "use_aes256_encryption" {
  description = "Attach Bucket policy to force SSL encyption"
  default     = false
}

variable "logging" {
  description = "Map containing access bucket logging configuration."
  type = object({
    target_bucket = string
    target_prefix = string
  })
  default = null
}

variable "additional_tags" {
  description = "Additional tags for the bucket"
  type        = map(string)
  default     = {}
}

variable "deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 10 days."
  default     = 10
}
