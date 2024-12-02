data "aws_iam_policy_document" "bucket_frontend" {
  statement {
    sid     = "AllowCloudfrontBucketAccess"
    effect  = "Allow"
    actions = ["s3:GetObject"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.this.iam_arn]
    }
    resources = ["${var.frontend_s3_bucket_arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "frontend" {
  bucket = var.frontend_s3_bucket_id
  policy = data.aws_iam_policy_document.bucket_frontend.json
}