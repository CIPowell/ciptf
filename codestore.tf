resource "aws_s3_bucket" "lambda_functions_dev" {
  bucket = "cip-lambda-store-dev"
  acl    = "private"

  tags {
    Name        = "Dev Lambda Functions"
    Environment = "Dev"
  }
}
