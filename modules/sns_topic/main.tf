resource "aws_sns_topic" "this" {
  name = var.name
}
resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = var.notification_email  # Email address to receive notifications
}
