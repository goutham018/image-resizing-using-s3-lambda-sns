# Root Module - main.tf

# Source Bucket - triggers Lambda on .jpg uploads
module "source_bucket" {
  source               = "./modules/s3_bucket"
  bucket_name          = "source-bucket-s3-233550"
  enable_notification  = true
  lambda_function_arn  = module.image_lambda.lambda_arn
  filter_suffix        = ".jpg"
  tags                 = local.common_tags
}

# Destination Bucket - stores resized images
module "destination_bucket" {
  source               = "./modules/s3_bucket"
  bucket_name          = "destination-bucket-s3-233550"
  enable_notification  = false
  tags                 = local.common_tags
}

# SNS Topic for notifications
module "sns_topic" {
  source             = "./modules/sns_topic"
  name               = "image-resizing-topic"
  notification_email = "gouthamr522@gmail.com"
}


# IAM Role for Lambda
module "lambda_role" {
  source               = "./modules/iam_role"
  role_name            = "image-resize-lambda-role"
  source_bucket_name   = module.source_bucket.bucket_name
  destination_bucket_name = module.destination_bucket.bucket_name
}


# Lambda Function for Image Resizing
module "image_lambda" {
  source                = "./modules/lambda_function"
  function_name         = "image-resize-function"
  handler               = "lambda_function.lambda_handler"
  runtime               = "python3.9"
  role_arn              = module.lambda_role.role_arn
  lambda_package        = "./lambda/image_resize_function.zip"
  environment_variables = {
    SOURCE_BUCKET = module.source_bucket.bucket_name
    DEST_BUCKET   = module.destination_bucket.bucket_name
    SNS_TOPIC_ARN = module.sns_topic.arn
  }
}

# Root Module - locals.tf
locals {
  common_tags = {
    Project     = "ImageResizeSystem"
    Environment = "dev"
  }
}

# Root Module - outputs.tf
output "lambda_function_name" {
  value = module.image_lambda.function_name
}

output "sns_topic_arn" {
  value = module.sns_topic.arn
}

output "source_bucket" {
  value = module.source_bucket.bucket_name
}

output "destination_bucket" {
  value = module.destination_bucket.bucket_name
}
