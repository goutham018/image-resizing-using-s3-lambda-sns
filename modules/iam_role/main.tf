# modules/iam_role/main.tf

resource "aws_iam_role" "lambda_exec" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda-permissions"
  role = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",  # Permission to read images from the source bucket
          "s3:PutObject"   # Permission to write images to the destination bucket
        ],
        Resource = [
          "arn:aws:s3:::${var.source_bucket_name}/*",  # Source bucket
          "arn:aws:s3:::${var.destination_bucket_name}/*"  # Destination bucket
        ]
      },
      {
        Effect = "Allow",
        Action = "sns:Publish",  # Permission to publish messages to SNS
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],  # Permissions to write logs (for Lambda execution logs)
        Resource = "*"
      }
    ]
  })
}
