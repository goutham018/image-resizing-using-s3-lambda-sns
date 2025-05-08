variable "name" {
  description = "The name of the SNS topic to create."
  type        = string
}

variable "notification_email" {
  description = "Email address for SNS notifications"
  type        = string
}