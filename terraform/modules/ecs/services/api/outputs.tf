output "task_role_arn" {
  value = aws_iam_role.task_role.arn
}

output "ecr_repo_name" {
  value = local.ecr_repo_name
}

output "registry_url" {
  value = split("/", aws_ecr_repository.this.repository_url)[0]
}

output "ecr_url" {
  value = aws_ecr_repository.this.repository_url
}

output "task_family_name" {
  value = aws_ecs_task_definition.this.family
}

output "codedeploy" {
  value = {
    app_name   = module.deploy.codedeploy_app_name
    group_name = module.deploy.codedeploy_deployment_group_name
  }
}

output "container_app_name" {
  value = var.app_name
}

output "ecs_service_name" {
  value = aws_ecs_service.this.name
}

output "ecs_service_arn" {
  value = aws_ecs_service.this.id
}

output "api_app_port" {
  value = var.port
}