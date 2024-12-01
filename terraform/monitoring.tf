module "sns_slack_topic" {
  count             = var.notifications_channel_slack_webhook != null ? 1 : 0
  source            = "./modules/sns"
  prefix            = local.prefix
  tags              = local.common_tags
  slack_webhook_url = var.notifications_channel_slack_webhook
}

module "grafana" {
    source = "./modules/grafana"

    prefix = local.prefix
    vpc_id = module.network.vpc_id
    vpc_subnets = module.network.private_subnets[*].id
    github_token = var.github_token

    api_logs_arn = module.service_api.logs_arn
    api_logs_name = module.service_api.logs_name
    api_svc_name = module.service_api.ecs_service_name

    task_runner_logs_arn = module.service_task_runner.logs_arn
    task_runner_logs_name = module.service_task_runner.logs_name
    task_runner_svc_name = module.service_task_runner.ecs_service_name

    sqs_tasks_name = module.tasks_sqs_queue.queue_name 
    alb_arn_suffix = module.service_api.alb_arn_suffix

    tags = local.common_tags
}

