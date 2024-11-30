data "aws_region" "current" {}

locals {
  service_prefix    = "${var.prefix}-${var.app_name}"
  initial_image_uri = length(data.aws_ecr_image.latest) > 0 ? data.aws_ecr_image.latest[0].image_uri : "scratch"
  ecr_repo_name     = "${local.service_prefix}-ecr"
}

resource "aws_ecr_repository" "this" {
  name                 = local.ecr_repo_name
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

data "aws_ecr_repository" "this" {
  name = aws_ecr_repository.this.name
}

data "aws_ecr_image" "latest" {
  count           = length(data.aws_ecr_repository.this.most_recent_image_tags) > 0 ? 1 : 0
  repository_name = data.aws_ecr_repository.this.name
  most_recent     = true
}


resource "aws_cloudwatch_log_group" "this" {
  name = "${local.service_prefix}-logs"
  tags = var.tags
}

resource "aws_cloudwatch_log_group" "xray" {
  name = "${local.service_prefix}-xray-logs"
  tags = var.tags
}