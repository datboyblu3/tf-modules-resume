resource "aws_acm_certificate" "alb-cert" {
  domain_name       = var.domain
  validation_method = "DNS"

  tags = {
    Environment = var.env
    Application = var.app
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener_certificate" "alb-cert" {
  depends_on      = [aws_acm_certificate.alb-cert]
  listener_arn    = aws_lb_listener.https.arn
  certificate_arn = aws_acm_certificate.alb-cert.arn
}
