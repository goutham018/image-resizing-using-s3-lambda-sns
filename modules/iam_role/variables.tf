variable "role_name" {
  description = "The name of the IAM role to create."
  type        = string
}

variable "source_bucket_name" {
  description = "The name of the source S3 bucket that the IAM role will access."
  type        = string
}

variable "destination_bucket_name" {
  description = "The name of the destination S3 bucket that the IAM role will access."
  type        = string
}
