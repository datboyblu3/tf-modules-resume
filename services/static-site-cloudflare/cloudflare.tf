data "cloudflare_zone" "domain" {
  name = var.site_domain
}

resource "cloudflare_record" "root" {
  name    = var.name
  type    = "CNAME"
  value   = "www.${var.site_domain}"
  zone_id = data.cloudflare_zone.domain.id
  ttl     = 1
}
