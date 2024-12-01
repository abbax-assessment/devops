terraform {
  required_providers {
    grafana = {
      source = "grafana/grafana"
      version = "3.13.2"
    }

    http = {
      source = "hashicorp/http"
      version = "3.4.5"
    }

    time = {
      source = "hashicorp/time"
      version = "0.12.1"
    }
  }
}

provider "grafana" {
  url  = "https://${aws_grafana_workspace.this.endpoint}"
  auth = aws_grafana_workspace_service_account_token.this.key
}



