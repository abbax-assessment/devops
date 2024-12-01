resource "null_resource" "grafana_dashboards" {
  count = var.grafana_auth != null && var.grafana_url != null ? 1 : 0

  triggers = {
    grafana_auth = var.grafana_auth
    grafana_url  = var.grafana_url
  }

  depends_on = []
}

resource "null_resource" "trigger_grafana_dashboards" {
  count = var.grafana_auth != null && var.grafana_url != null ? 1 : 0

  depends_on = [module.grafana_dashboards]
}

module "grafana_dashboards" {
    source = "./modules/grafana"

    grafana_auth = var.grafana_auth
    grafana_url = var.grafana_url
}

