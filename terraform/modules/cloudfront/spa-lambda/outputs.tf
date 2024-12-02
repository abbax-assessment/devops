output "lambda_arn" {
  value = "${aws_lambda_function.this.arn}:${aws_lambda_function.this.version}"
}