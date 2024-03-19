resource "cloudflare_record" "root" {
  zone_id = data.cloudflare_zones.domain.id
  name    = "${var.env}-${var.app}-root"
  value = aws_eip.elastic_ip.public_ip
  type = "A"
  ttl = 3600
}

resource "cloudflare_record" "blog" {
  zone_id = data.cloudflare_zones.domain.id
  name = "${var.env}-${var.app}-blog"
  value = aws_eip.elastic_ip.public_ip
  type = "A"
  ttl = 3600
}
