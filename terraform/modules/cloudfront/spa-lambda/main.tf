
//tfsec:ignore:aws-lambda-enable-tracing
resource "aws_lambda_function" "this" {
  function_name = "${var.prefix}-spa-redirections"

  s3_bucket = aws_s3_bucket.src.id
  s3_key    = aws_s3_object.src.key

  runtime = "nodejs16.x"
  handler = "index.handler"
  publish = true

  source_code_hash = data.archive_file.src.output_base64sha256

  role = aws_iam_role.this.arn

  lifecycle {
    ignore_changes = [source_code_hash]
  }
}
