resource "aws_s3_bucket" "this" {
  bucket        = "${var.env}-${var.app}-${var.type}"
  force_destroy = var.is_destroy
  tags          = var.resource_tags
}

resource "aws_s3_bucket_versioning" "this" {
  count  = var.enable_bucket_versioning ? 1 : 0
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_website_configuration" "this" {
  count  = var.enable_web ? 1 : 0
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}


resource "aws_s3_bucket_public_access_block" "public_access" {
  depends_on              = [aws_s3_bucket.this, aws_s3_bucket_website_configuration.this]
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = var.public
  block_public_policy     = var.public
  ignore_public_acls      = var.public
  restrict_public_buckets = var.public
}
