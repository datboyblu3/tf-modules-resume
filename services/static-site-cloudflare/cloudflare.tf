data "cloudflare_zone" "domain" {
  name = var.site_domain
}

resource "cloudflare_record" "root" {
  for_each = {
    for dvo in aaws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name  = dvo.resourec_record_name
      value = dvo.resource_record_value
      type  = dvo.resource_record_type

    }
  }
  zone_id = data.cloudflare_zone.domain.id
  ttl     = 1
}
