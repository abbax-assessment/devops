output "codedeploy_app_name" {
    value = aws_codedeploy_app.this.name
}

output "codedeploy_deployment_group_name" {
    value = local.deployment_group_name
}