data "cloudflare_zones" "domain" {
  filter {
    name = var.site_domain
  }
}

resource "cloudflare_record" "cname" {
  # depends_on = [aws_cloudfront_distribution.dist]
  zone_id    = data.cloudflare_zones.domain.zones[0].id
  name       = var.site_domain
  value      = var.site_domain
  type       = "CNAME"

  ttl     = 1
  proxied = true
}

