data "template_file" "app_performance" {
  template = file("${path.module}/dashboards/app-performance.json.tpl")
  vars = {
    environment = terraform.workspace
  }
}

resource "grafana_dashboard" "app_performance" {
  config_json = data.template_file.app_performance.rendered
}