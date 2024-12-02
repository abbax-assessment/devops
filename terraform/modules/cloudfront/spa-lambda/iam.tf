data "aws_iam_policy_document" "this" {
  statement {
    sid     = "LambdaEdgeAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
        "edgelambda.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = "${var.prefix}-lambda-edge-role-spa"
  assume_role_policy = data.aws_iam_policy_document.this.json

  tags = var.tags
}