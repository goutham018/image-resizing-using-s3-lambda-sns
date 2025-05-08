# modules/lambda_function/outputs.tf

output "lambda_arn" {
  value = aws_lambda_function.this.arn
}

output "function_name" {
  value = aws_lambda_function.this.function_name
}
