#selects the existing hosted zone. I don't tend to automate the creation of this
data "aws_route53_zone" "selected" {
  name         = var.domain
  private_zone = false
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.sub_domain_1
  type    = "A"
  ttl     = 300
  records = [aws_eip.r0land-link.public_ip]
}

resource "aws_route53_record" "blog" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.sub_domain_2
  type    = "A"
  ttl     = 300
  records = [aws_eip.r0land-link.public_ip]
}

resource "aws_eip" "r0land-link" {
  vpc = true
}

