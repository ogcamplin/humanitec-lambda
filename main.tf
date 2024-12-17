provider "aws" {
  region = "ap-southeast-2" # Replace with your desired region
}

# Create an IAM role for the Lambda function
resource "aws_iam_role" "lambda_role" {
  name = "lambda-basic-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement: [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach a policy to the Lambda role
resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda-basic-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement: [
      {
        Effect   = "Allow",
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# Create the Lambda function
resource "aws_lambda_function" "this" {
  function_name = "example-lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler" # Update based on your function
  runtime       = "python3.9"                     # Adjust for your language
  timeout       = 10
  memory_size   = 128

  s3_bucket = var.s3_bucket_id
  s3_key    = var.s3_object_key
}

# Output the Lambda ARN

