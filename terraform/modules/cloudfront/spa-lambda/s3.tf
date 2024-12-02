data "archive_file" "src" {
  type = "zip"

  source_dir  = "${path.module}/src"
  output_path = "${path.module}/spa_lambda_src.zip"
}

resource "aws_s3_object" "src" {
  bucket = aws_s3_bucket.src.id

  key    = "spa_lambda_src.zip"
  source = data.archive_file.src.output_path
}

resource "aws_s3_bucket" "src" {
  bucket = "${var.prefix}-lambda-at-edge-spa"
  tags   = var.tags
}

resource "aws_s3_bucket_public_access_block" "frontend_src" {
  bucket                  = aws_s3_bucket.src.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "src" {
  bucket = aws_s3_bucket.src.id
  versioning_configuration {
    status = "Enabled"
  }
}