variable "function_name" {
  description = "The name of the Lambda function."
  type        = string
}

variable "handler" {
  description = "The function within your Lambda code that Lambda calls to begin execution."
  type        = string
}

variable "runtime" {
  description = "The runtime environment for the Lambda function (e.g., 'nodejs14.x', 'python3.8')."
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role that Lambda assumes when it executes."
  type        = string
}

variable "lambda_package" {
  description = "The path to the deployment package (e.g., zip file) for the Lambda function."
  type        = string
}

variable "environment_variables" {
  description = "A map of environment variables to pass to the Lambda function."
  type        = map(string)
  default     = {}  # Default to an empty map, so no environment variables unless specified
}
