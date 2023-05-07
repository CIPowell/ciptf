provider "aws" {
  region = "eu-west-1"
}

resource "aws_route53_zone" "chrisipowell_co_uk" {
    name = "chrisipowell.co.uk."
}

resource "aws_route53_record" "google_search_console_verification" {
  zone_id = aws_route53_zone.chrisipowell_co_uk
  name = "@"
  ttl = 600
  type = "TXT"
  records = [  
    "google-site-verification=QVqHNkgfg3NykWtYY453hHrLg_J76Att6rl8fm1pVpA"
  ]
}
