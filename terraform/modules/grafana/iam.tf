data "aws_iam_policy_document" "assume" {
  statement {
    sid     = "TaskExecutionAssumeRole"
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
    sid       = "AllowECROperations"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowAthenaAccess"
    effect = "Allow"
    actions = [
      "athena:*"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowCloudwatchOperations"
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "${aws_cloudwatch_log_group.this.arn}:*",
      "${aws_cloudwatch_log_group.xray.arn}:*"
    ]
  }
}


resource "aws_iam_role" "assume" {
  name = "${var.prefix}-grafana-assume-role"
  assume_role_policy = data.aws_iam_policy_document.assume.json
}

resource "aws_iam_policy" "task_exec_role_policy" {
  name   = "${var.prefix}-grafana-role-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.policy.json
}
