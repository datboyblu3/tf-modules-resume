data "cloudflare_zone" "domain" {
  name = var.site_domain
}

resource "cloudflare_record" "root" {
  zone_id = data.cloudflare_zone.domain.id
  name    = "@"
  value   = "www.${aws_acm_certificate.cert.domain_name}"
  type    = "CNAME"
  ttl     = 1
}
