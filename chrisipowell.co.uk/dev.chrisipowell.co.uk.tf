resource "aws_s3_bucket" "website_devchrisipowell" {
  bucket = "dev.chrisipowell.co.uk"
  acl = "public-read"

  tags {
    Name        = "ChrisIPowell.co.uk Staging Static Site"
    Environment = "Staging"
  }

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}

resource "aws_route53_record" "staging" {
    zone_id = "${aws_route53_zone.chrisipowell_co_uk.zone_id}"
    name = "dev.${aws_route53_zone.chrisipowell_co_uk.name}"
    type = "A"
    alias {
      name = "${aws_s3_bucket.website_devchrisipowell.website_domain}"
      zone_id = "${aws_s3_bucket.website_devchrisipowell.hosted_zone_id}"
      evaluate_target_health = true
    }
}
