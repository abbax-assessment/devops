resource "grafana_data_source" "cloudwatch" {
  type = "cloudwatch"
  name = "cw"

  json_data_encoded = jsonencode({
    defaultRegion = "eu-west-1"
    authType      = "workspace_assume_role"
  })
}

data "http" "xray_install" {
  url = "https://${aws_grafana_workspace.this.endpoint}/api/plugins/grafana-x-ray-datasource/install"

  request_headers = {
    Authorization = "Bearer ${aws_grafana_workspace_service_account_token.this.key}"
    Content-Type  = "application/json"
  }

  method = "POST"
}

resource "grafana_data_source" "xray" {
  type = "grafana-x-ray-datasource"
  name = "xray"

  json_data_encoded = jsonencode({
    defaultRegion = "eu-west-1"
  })

  depends_on = [ data.http.xray_install ]
}

data "http" "github_install" {
  url = "https://${aws_grafana_workspace.this.endpoint}/api/plugins/grafana-github-datasource/install"

  request_headers = {
    Authorization = "Bearer ${aws_grafana_workspace_service_account_token.this.key}"
    Content-Type  = "application/json"
  }

  method = "POST"
}

resource "grafana_data_source" "github" {
  type = "grafana-github-datasource"
  name = "github"

  json_data_encoded = jsonencode({
    githubPlan = "github-basic"
    selectedAuthType = "personal-access-token"
    accessToken = var.github_token
  })

  depends_on = [ data.http.github_install ]
}

data "http" "athena_install" {
  url = "https://${aws_grafana_workspace.this.endpoint}/api/plugins/grafana-athena-datasource/install"

  request_headers = {
    Authorization = "Bearer ${aws_grafana_workspace_service_account_token.this.key}"
    Content-Type  = "application/json"
  }

  method = "POST"
}

resource "grafana_data_source" "athena" {
  type = "grafana-athena-datasource"
  name = "athena"

  json_data_encoded = jsonencode({
    defaultRegion = "eu-west-1"
    catalog = "AwsDataCatalog"
    database = "github_dev_data"
    workgroup = "tsk-dev-github-workgroup"
  })

  depends_on = [ data.http.athena_install ]
}
