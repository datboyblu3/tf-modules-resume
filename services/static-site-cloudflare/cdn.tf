resource "aws_acm_certificate" "cert" {
  domain_name       = var.site_domain
  validation_method = "DNS"
  tags              = var.resource_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "validate" {
  depends_on      = [aws_acm_certificate.cert]
  certificate_arn = aws_acm_certificate.cert.arn
}

resource "aws_cloudfront_distribution" "dist" {
  depends_on = [aws_s3_bucket.site, aws_acm_certificate_validation.validate]

  origin {
    domain_name = var.site_domain
    origin_id   = "S3-${var.site_domain}"
  }

  enabled             = true
  default_root_object = "index.html"

  aliases = [var.site_domain]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.site_domain}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate_validation.validate.certificate_arn
    ssl_support_method  = "sni-only"
  }

  tags = var.resource_tags
}
