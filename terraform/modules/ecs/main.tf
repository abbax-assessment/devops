resource "aws_ecs_cluster" "this" {
  name = "${var.prefix}-ecs-cluster"

  lifecycle {
    ignore_changes = [setting]
  }

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = var.tags
}