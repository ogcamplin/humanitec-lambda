provider "aws" {
  region     = var.REGION
  access_key = var.ACCESS_KEY_ID
  secret_key = var.ACCESS_KEY_VALUE
  token      = var.SESSION_TOKEN
}

# Create the Lambda function
resource "aws_lambda_function" "this" {
  function_name = var.lambda_name
  role          = "arn:aws:iam::146609405994:role/lambda-basic-role"
  handler       = "lambda_function.lambda_handler" # Update based on your function
  runtime       = "python3.9"                     # Adjust for your language
  timeout       = 10
  memory_size   = 128

  s3_bucket = var.s3_bucket_id
  s3_key    = var.s3_object_key

  tags = {
    "application_id" = var.application_id
    "airnz_compliant" = "true"
  }
}

# Output the Lambda ARN

