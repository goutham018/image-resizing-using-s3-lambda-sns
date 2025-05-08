variable "bucket_name" {
  description = "The name of the S3 bucket to create."
  type        = string
}

variable "enable_notification" {
  description = "A boolean flag to enable or disable S3 event notifications."
  type        = bool
  default     = false  # Default to false (i.e., notifications are off by default)
}

variable "lambda_function_arn" {
  description = "The ARN of the Lambda function to trigger on S3 object creation."
  type        = string
  default     = ""  # Empty string by default, meaning no Lambda trigger unless specified
}

variable "filter_suffix" {
  description = "The suffix to filter the S3 objects for the notification trigger (e.g., '.jpg')."
  type        = string
  default     = ""  # No suffix filter by default
}

variable "tags" {
  description = "A map of key-value pairs to tag the S3 bucket."
  type        = map(string)
  default     = {}  # Default to empty map, meaning no tags unless specified
}