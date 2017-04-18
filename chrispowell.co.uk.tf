resource "aws_s3_bucket" "website_chrisipowell" {
  bucket = "chrisipowell"
  acl = "public-read"

  tags {
    Name        = "ChrisIPowell.co.uk Static Site"
    Environment = "Live"
  }

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}

resource "aws_route53_zone" "chrisipowell_co_uk" {
    name = "chrisipowell.co.uk."

}

resource "aws_cloudfront_distribution" "chrisipowell_static" {
   origin {
     domain_name = "${aws_s3_bucket.website_chrisipowell.bucket_domain_name}"
     origin_id = "S3-Website-chrisipowell.s3-website-eu-west-1.amazonaws.com"

     custom_origin_config {
       http_port = 80
       https_port = 443

       origin_protocol_policy = "http-only"
       origin_ssl_protocols  = [ "TLSv1.2" ]
     }
   }

   enabled = true
   is_ipv6_enabled = true
   comment= "Managed by Terraform"
   default_root_object = "index.html"

   restrictions {
     geo_restriction {
       restriction_type = "none"
     }
   }

   aliases = ["chrisipowell.co.uk", "www.chrisipowell.co.uk"]

   default_cache_behavior {
     allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
     cached_methods = ["GET", "HEAD"]
     target_origin_id = "S3-Website-chrisipowell.s3-website-eu-west-1.amazonaws.com"

     default_ttl = 86400
     max_ttl = 604800
     min_ttl = 0

     compress = true

     viewer_protocol_policy = "redirect-to-https"

     forwarded_values {
       query_string = false

       cookies {
         forward = "none"
       }
     }
   }
   tags {
     Environment = "production"
   }

   viewer_certificate {
     cloudfront_default_certificate = true
     ssl_support_method = "sni-only"
     acm_certificate_arn = "arn:aws:acm:us-east-1:161480166635:certificate/93763cc4-ec84-478d-bc77-a245310b7904"
     minimum_protocol_version = "TLSv1"
   }
}
