terraform {
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "3.4.5"
    }

    grafana = {
      source  = "grafana/grafana"
      version = "3.13.2"
    }
  }
}

provider "grafana" {
  url  = var.grafana_workspace_url
  auth = aws_grafana_workspace_service_account_token.this.key
}

resource "time_rotating" "this" {
  rotation_minutes = 1000000
}

# state rm module.aws_grafana.aws_grafana_workspace_service_account_token.this
resource "aws_grafana_workspace_service_account_token" "this" {
  name               = "tsk-dev-tf-admin-key-2024-12-03T03:15:52Z"
  service_account_id = var.grafana_service_account_id
  seconds_to_live    = 2592000
  workspace_id       = var.grafana_workspace_id

  # depends_on = [time_rotating.this]
}

resource "grafana_data_source" "cloudwatch" {
  type = "cloudwatch"
  name = "cw"

  json_data_encoded = jsonencode({
    defaultRegion = "eu-west-1"
    authType      = "workspace_assume_role"
  })
}

data "http" "xray_install" {
  url = "${var.grafana_workspace_url}/api/plugins/grafana-x-ray-datasource/install"

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

  depends_on = [
    data.http.xray_install,
    aws_grafana_workspace_service_account_token.this
  ]
}

data "http" "github_install" {
  url = "${var.grafana_workspace_url}/api/plugins/grafana-github-datasource/install"

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
    githubPlan       = "github-basic"
    selectedAuthType = "personal-access-token"
    accessToken      = var.github_token
  })

  depends_on = [
    data.http.github_install,
    aws_grafana_workspace_service_account_token.this
  ]
}

data "http" "athena_install" {
  url = "${var.grafana_workspace_url}/api/plugins/grafana-athena-datasource/install"

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
    authType      = "workspace_assume_role"
    defaultRegion = "eu-west-1"
    catalog       = "AwsDataCatalog"
    database      = "github_dev_data"
    workgroup     = "tsk-dev-github-workgroup"
  })

  depends_on = [
    data.http.athena_install,
    aws_grafana_workspace_service_account_token.this
  ]
}

data "http" "alarms_install" {
  url = "${var.grafana_workspace_url}/api/plugins/computest-cloudwatchalarm-datasource/install"

  request_headers = {
    Authorization = "Bearer ${aws_grafana_workspace_service_account_token.this.key}"
    Content-Type  = "application/json"
  }

  method = "POST"
}

resource "grafana_data_source" "alarms" {
  type = "computest-cloudwatchalarm-datasource"
  name = "cw-alarms"

  json_data_encoded = jsonencode({
    authType = "workspace_assume_role"
  })

  depends_on = [
    data.http.alarms_install,
    aws_grafana_workspace_service_account_token.this
  ]
}

