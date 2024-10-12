variable "environment" {
  description = "Deployment environment/stage (e.g. test, e2e, prod or int)"
  type        = string
}

variable "profile" {
  description = "Name of the AWS profile in ~/.aws/config"
  type        = string
}

variable "role_arn" {
  type = string
}

variable "project" {
  description = "Specify to which project this resource belongs"
  default     = "tripsner"
}

variable "region" {
  description = "Default Region for Cloud Analytics Platform"
  default     = "eu-west-3"
}

variable "functional_resource" {
  description = "Functional resource to deploy"
  type        = string
}