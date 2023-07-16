# application load balancer, listner, target group and listener rule
resource "aws_lb" "alb" {
  depends_on         = [aws_s3_bucket.access_logs]
  name               = "${var.app}-alb"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.alb.id]

  access_logs {
    bucket  = var.log-bucket
    prefix  = var.app
    enabled = true
  }

}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = local.http_port
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = local.https_port
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = local.https_port
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.alb-cert.arn
  depends_on        = [aws_lb_target_group.asg]

  default_action {
    target_group_arn = aws_lb_target_group.asg.arn
    type             = "forward"
  }
}



resource "aws_lb_target_group" "asg" {
  name        = "${var.cluster_name}-tgt-grp"
  target_type = "alb"
  port        = local.http_port
  protocol    = "TCP"
  vpc_id      = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100
  condition {
    path_pattern {
      values = ["*"]
    }
  }
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}
