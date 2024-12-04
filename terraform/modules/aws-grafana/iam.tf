data "aws_iam_policy_document" "assume" {
  statement {
    sid     = "GrafanaAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["grafana.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "policy" {
  statement {
    sid    = "GrafanaAccess"
    effect = "Allow"
    actions = [
      "athena:*",
      "glue:*",
      "cloudwatch:GetMetricData",
      "cloudwatch:DescribeAlarms",
      "xray:GetServiceGraph",
      "xray:GetGroup",
      "xray:GetGroups",
      "xray:GetTraceGraph",
      "xray:StartTraceRetrieval",
      "xray:GetTraceSummaries",
      "xray:GetTraceSegmentDestination",
      "xray:GetTimeSeriesServiceStatistics",
      "xray:GetSamplingTargets",
      "xray:GetSamplingStatisticSummaries",
      "xray:GetSamplingRules",
      "xray:GetRetrievedTracesGraph",
      "xray:GetInsightSummaries",
      "xray:GetInsightImpactGraph",
      "xray:GetInsightEvents",
      "xray:GetInsight",
      "xray:GetIndexingRules",
      "xray:GetEncryptionConfig",
      "xray:GetDistinctTraceGraphs",
      "xray:CancelTraceRetrieval",
      "xray:BatchGetTraceSummaryById",
      "logs:DescribeLogStreams",
      "logs:DescribeLogGroups",
      "logs:StartQuery",
      "logs:StopQuery",
      "logs:GetQueryResults",

    ]
    resources = ["*"]
  }

  statement {
    sid = "AllowS3Access"
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:GetBucketLocation"
    ]
    resources = [
      var.github_athena_s3,
      "${var.github_athena_s3}/*"
    ]
  }
}

resource "aws_iam_role" "assume" {
  name               = "${var.prefix}-grafana-assume-role"
  assume_role_policy = data.aws_iam_policy_document.assume.json
}

resource "aws_iam_policy" "grafana" {
  name   = "${var.prefix}-grafana-role-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_role_policy_attachment" "policy" {
  role       = aws_iam_role.assume.name
  policy_arn = aws_iam_policy.grafana.arn
}