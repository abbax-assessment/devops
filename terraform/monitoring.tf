module "sns_slack_topic" {
  count             = var.notifications_channel_slack_webhook != null ? 1 : 0
  source            = "./modules/sns"
  prefix            = local.prefix
  tags              = local.common_tags
  slack_webhook_url = var.notifications_channel_slack_webhook
}

module "aws_grafana" {
  source = "./modules/aws-grafana"

  prefix      = local.prefix
  vpc_id      = module.network.vpc_id
  vpc_subnets = module.network.private_subnets[*].id

  tags = local.common_tags
}

module "grafana_dashboards" {
  source = "./modules/aws-grafana/dashboards"
  providers = {
    grafana = grafana
  }

  prefix = local.prefix

  grafana_service_token = module.aws_grafana.github_service_token
  grafana_workspace_url = "https://${module.aws_grafana.grafana_workspace_url}"
  github_token          = var.github_token

  # aws resources for the dashboards
  api_logs_arn          = module.service_api.logs_arn
  api_logs_name         = module.service_api.logs_name
  api_svc_name          = module.service_api.ecs_service_name
  task_runner_logs_arn  = module.service_task_runner.logs_arn
  task_runner_logs_name = module.service_task_runner.logs_name
  task_runner_svc_name  = module.service_task_runner.ecs_service_name
  sqs_tasks_name        = module.tasks_sqs_queue.queue_name
  alb_arn_suffix        = module.service_api.alb_arn_suffix

  tags = local.common_tags

  depends_on = [
    module.aws_grafana
  ]
}