# modules/s3_bucket/main.tf

resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = true
  tags          = var.tags
}

resource "aws_s3_bucket_notification" "lambda_trigger" {
  count  = var.enable_notification ? 1 : 0
  bucket = aws_s3_bucket.this.id

  lambda_function {
    lambda_function_arn = var.lambda_function_arn
    events              = ["s3:ObjectCreated:Put"]
    filter_suffix       = var.filter_suffix
  }

  depends_on = [aws_s3_bucket.this]
}
