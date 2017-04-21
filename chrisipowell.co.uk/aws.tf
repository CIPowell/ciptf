provider "aws" {
  region = "eu-west-1"
}

resource "aws_route53_zone" "chrisipowell_co_uk" {
    name = "chrisipowell.co.uk."
}
