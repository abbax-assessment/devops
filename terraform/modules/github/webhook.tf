data "aws_caller_identity" "current" {}

resource "github_organization_webhook" "this" {
  configuration {
    url          = aws_apigatewayv2_api.github_webhook_api.api_endpoint
    content_type = "json"
    insecure_ssl = true # TODO
  }

  active = true

  events = [
    "deployment",
    "deployment_status",
    "push",
    "workflow_job",
    "workflow_run"
  ]
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/webhook-handler"
  output_path = "${path.module}/webhook-handler.zip"
}

resource "aws_lambda_function" "github_webhook_handler" {
  function_name    = "${var.prefix}-github-webhook-lambda"
  handler          = "index.handler"
  runtime          = "nodejs16.x"
  role             = aws_iam_role.lambda_execution_role.arn
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      "FIREHOSE_STREAM_NAME" = aws_kinesis_firehose_delivery_stream.firehose_to_s3.name
    }
  }

  tracing_config {
    mode = "Active"
  }

  tags = var.tags
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "${var.prefix}-github-webhook-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name = "${var.prefix}-github-webhook-lambda-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:logs:*:*:*"
        ]
      },
      {
        Action = [
          "firehose:PutRecord"
        ]
        Effect   = "Allow"
        Resource = [aws_kinesis_firehose_delivery_stream.firehose_to_s3.arn]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_apigatewayv2_api" "github_webhook_api" {
  name          = "${var.prefix}-github-webhook-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.github_webhook_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.github_webhook_handler.arn
  payload_format_version = "2.0"
  depends_on             = [aws_lambda_permission.api_gateway_invoke]
}

resource "aws_apigatewayv2_route" "default_route" {
  api_id    = aws_apigatewayv2_api.github_webhook_api.id
  route_key = "POST /" # GitHub webhooks send POST requests

  target = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.github_webhook_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "api_gateway_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.github_webhook_handler.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.github_webhook_api.execution_arn}/*/*"
}

resource "aws_s3_bucket" "github_events" {
  bucket = "${var.prefix}-github-events"
  tags   = var.tags
}

resource "aws_s3_bucket_policy" "firehose_bucket_policy" {
  bucket = aws_s3_bucket.github_events.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowFirehoseWrite"
        Effect = "Allow"
        Principal = {
          Service = "firehose.amazonaws.com"
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.github_events.arn}/*"
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = data.aws_caller_identity.current.account_id
          }
        }
      }
    ]
  })
}

resource "aws_iam_role" "firehose_role" {
  name = "${var.prefix}-github-firehose-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "firehose.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "firehose_policy" {
  name = "${var.prefix}-github-firehose-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect = "Allow"
        Action = ["s3:PutObject", "s3:GetObject", "s3:ListBucket"]
        Resource = [
          aws_s3_bucket.github_events.arn,
          "${aws_s3_bucket.github_events.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "firehose_policy_attachment" {
  role       = aws_iam_role.firehose_role.name
  policy_arn = aws_iam_policy.firehose_policy.arn
}

resource "aws_kinesis_firehose_delivery_stream" "firehose_to_s3" {
  name        = "${var.prefix}-firehose-stream"
  destination = "extended_s3"


  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_role.arn
    bucket_arn = aws_s3_bucket.github_events.arn

    dynamic_partitioning_configuration {
      enabled        = true
      retry_duration = 30
    }

    prefix              = "raw/event_type=!{partitionKeyFromQuery:event_type}/project=!{partitionKeyFromQuery:project}/branch=!{partitionKeyFromQuery:branch}/year=!{timestamp:yyyy}-month=!{timestamp:MM}-day=!{timestamp:dd}/" # Dynamic folder paths
    error_output_prefix = "error-logs/"

    buffering_interval = 60
    buffering_size     = 64

    compression_format = "GZIP"

    processing_configuration {
      enabled = true

      # New line delimiter
      processors {
        type = "AppendDelimiterToRecord"
      }

      # JQ processor to extract partition metadata
      processors {
        type = "MetadataExtraction"

        parameters {
          parameter_name  = "JsonParsingEngine"
          parameter_value = "JQ-1.6"
        }

        parameters {
          parameter_name  = "MetadataExtractionQuery"
          parameter_value = "{event_type:.event_type, project:.project, branch:.branch}"
        }
      }
    }

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = "/aws/kinesisfirehose/${var.prefix}-firehose-stream"
      log_stream_name = "S3Delivery"
    }
  }
}