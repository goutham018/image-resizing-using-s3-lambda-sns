# modules/lambda_function/main.tf

resource "aws_lambda_function" "this" {
  function_name = var.function_name
  handler       = var.handler
  runtime       = var.runtime
  role          = var.role_arn
  filename      = var.lambda_package

  source_code_hash = filebase64sha256(var.lambda_package)
  timeout          = 30

  environment {
    variables = var.environment_variables
  }
}
