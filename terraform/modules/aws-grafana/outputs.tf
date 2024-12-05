output "grafana_workspace_url" {
  value = aws_grafana_workspace.this.endpoint
}

output "grafana_service_account_id" {
  value = aws_grafana_workspace_service_account.this.service_account_id
}

output "grafana_workspace_id" {
  value = aws_grafana_workspace.this.id
}


