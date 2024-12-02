output "grafana_workspace_url" {
  value = aws_grafana_workspace.this.endpoint
}

output "github_service_token" {
  value = aws_grafana_workspace_service_account_token.this.key
}