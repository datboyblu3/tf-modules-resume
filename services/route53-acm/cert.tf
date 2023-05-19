#creates a private key used for certificate registration
resource "tls_private_key" "reg_private_key" {
  algorithm = "RSA"
}

#Registers an account with acme
resource "acme_registration" "registration" {
  account_key_pem = tls_private_key.reg_private_key.private_key_pem
  email_address   = var.email # set emai variable and pass it via tfvars
}

#Creates a certifcate using the account registration key and the cert request key
resource "acme_certificate" "certificate" {
  account_key_pem               = acme_registration.registration.account_key_pem
  common_name                   = var.domain
  revoke_certificate_on_destroy = "true"
  subject_alternative_names     = [var.sub_domain_1, var.sub_domain_2]
  dns_challenge {
    provider = "route53"

    config = {
      AWS_HOSTED_ZONE_ID = data.aws_route53_zone.selected.zone_id
    }
  }

  depends_on = [acme_registration.registration]
}

#places the certificate in ACM for use with a load balancer
resource "aws_acm_certificate" "certificate" {
  certificate_body  = acme_certificate.certificate.certificate_pem
  private_key       = acme_certificate.certificate.private_key_pem
  certificate_chain = acme_certificate.certificate.issuer_pem
}
