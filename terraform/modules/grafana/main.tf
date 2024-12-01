terraform {
  required_providers {
    grafana = {
      source = "grafana/grafana"
      version = "3.13.2"
    }
  }
}

provider "grafana" {
  url  = var.grafana_url
  auth = var.grafana_auth
}