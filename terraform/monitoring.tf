module "sns_slack_topic" {
  source            = "./modules/sns"
  prefix            = local.prefix
  tags              = local.common_tags
  slack_webhook_url = var.slack_webhook_url
}

module "aws_grafana" {
  source = "./modules/aws-grafana"

  prefix           = local.prefix
  vpc_id           = module.network.vpc_id
  vpc_subnets      = module.network.private_subnets[*].id
  github_athena_s3 = module.github.bucket_arn

  tags = local.common_tags
}

module "grafana_api" {
  source = "./modules/aws-grafana/grafana-api"

  prefix = local.prefix


  grafana_workspace_id       = module.aws_grafana.grafana_workspace_id
  grafana_workspace_url      = "https://${module.aws_grafana.grafana_workspace_url}"
  grafana_service_account_id = module.aws_grafana.grafana_service_account_id

  github_token = var.github_token

  # aws resources for the dashboards
  dynamodb_tasks_table_name = module.tasks_dynamodb_table.table_name
  api_logs_arn              = module.service_api.logs_arn
  api_logs_name             = module.service_api.logs_name
  api_svc_name              = module.service_api.ecs_service_name
  task_runner_logs_arn      = module.service_task_runner.logs_arn
  task_runner_logs_name     = module.service_task_runner.logs_name
  task_runner_svc_name      = module.service_task_runner.ecs_service_name
  sqs_tasks_name            = module.tasks_sqs_queue.queue_name
  sqs_tasks_dlq_name        = module.tasks_sqs_queue.dlq_queue_name
  alb_arn_suffix            = module.service_api.alb_arn_suffix

  tags = local.common_tags
}