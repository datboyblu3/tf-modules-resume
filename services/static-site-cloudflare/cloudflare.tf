data "cloudflare_zone" "domain" {
  name = var.site_domain
}

resource "cloudflare_record" "acm" {
  depends_on = [aws_acm_certificate.cert]

  zone_id = data.cloudflare_zone.domain.id
  name    = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
  value   = [tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value]
  type    = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_type
}


resource "cloudflare_record" "cname" {
  depends_on = [aws_cloudfront_distribution.dist]

  zone_id = data.cloudflare_zone.domain.id
  name    = var.site_domain
  value   = aws_cloudfront_distribution.dist.domain_name
  type    = "CNAME"
}

