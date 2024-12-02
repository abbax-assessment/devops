output "task_role_arn" {
  value = aws_iam_role.task_role.arn
}

output "ecr_repo_name" {
  value = local.ecr_repo_name
}

output "container_app_name" {
  value = var.app_name
}

output "task_family_name" {
  value = aws_ecs_task_definition.this.family
}

output "ecs_service_name" {
  value = aws_ecs_service.this.name
}

output "logs_arn" {
  value = aws_cloudwatch_log_group.this.arn
}

output "logs_name" {
  value = aws_cloudwatch_log_group.this.name
}