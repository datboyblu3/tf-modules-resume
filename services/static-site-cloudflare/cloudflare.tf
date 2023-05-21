data "cloudflare_zones" "domain" {
  filter {
    name = var.site_domain
  }
}

resource "cloudflare_record" "cname" {
  # depends_on = [aws_cloudfront_distribution.dist]
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = var.name
  value   = var.site_domain
  type    = "CNAME"

  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "root" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = "@"
  value   = aws_acm_certificate.cert.domain_name
  type    = "CNAME"
  ttl     = 1
}
