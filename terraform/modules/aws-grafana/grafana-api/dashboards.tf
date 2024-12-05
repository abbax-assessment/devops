data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "template_file" "app_performance" {
  template = file("${path.module}/templates/app-performance.json.tpl")
  vars = {
    title                              = "${var.prefix}-app-performance"
    default_region                     = data.aws_region.current.name
    account_id                         = data.aws_caller_identity.current.account_id
    environment                        = terraform.workspace
    dynamodb_tasks_table_name          = var.dynamodb_tasks_table_name
    task_runner_logs_arn               = var.task_runner_logs_arn
    task_runner_logs_name              = var.task_runner_logs_name
    api_logs_arn                       = var.api_logs_arn
    api_logs_name                      = var.api_logs_name
    task_runner_svc_name               = var.task_runner_svc_name
    api_svc_name                       = var.api_svc_name
    sqs_tasks_name                     = var.sqs_tasks_name
    sqs_tasks_dlq_name                 = var.sqs_tasks_dlq_name
    alb_arn_suffix                     = var.alb_arn_suffix
    cloudwatch_data_source_type        = grafana_data_source.cloudwatch.type
    cloudwatch_data_source_id          = grafana_data_source.cloudwatch.uid
    xray_data_source_type              = grafana_data_source.xray.type
    xray_data_source_id                = grafana_data_source.xray.uid
    cloudwatch_alarms_data_source_type = grafana_data_source.alarms.type
    cloudwatch_alarms_data_source_type = grafana_data_source.alarms.uid
  }
}

resource "grafana_dashboard" "app_performance" {
  config_json = data.template_file.app_performance.rendered
  lifecycle {
    ignore_changes = [config_json]
  }
}

data "template_file" "devops" {
  template = file("${path.module}/templates/devops.json.tpl")
  vars = {
    title                   = "${var.prefix}-devops"
    environment             = terraform.workspace
    athena_data_source_type = grafana_data_source.athena.type
    athena_data_source_id   = grafana_data_source.athena.uid
  }
}

resource "grafana_dashboard" "devops" {
  config_json = data.template_file.devops.rendered
  lifecycle {
    ignore_changes = [config_json]
  }
}