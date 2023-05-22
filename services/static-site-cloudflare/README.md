
Format of aws_acm_certificate_validation.domain_validation_options

Ref: https://github.com/hashicorp/terraform/issues/26043#issuecomment-683119243

After the upgrade to terraform 0.13 you can't use the domain_validation_options[0] or domain_validation_options.0.

To make the reference work, use tolist(aws_acm_certificate.example.domain_validation_options)[0])

