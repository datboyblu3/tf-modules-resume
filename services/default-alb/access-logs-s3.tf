resource "aws_s3_bucket" "access_logs" {
  bucket = "${var.bucket}-logs"

  tags = {
    Environment = var.env
    Application = var.app
  }
}
