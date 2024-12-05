module "ecs" {
  source = "./modules/ecs"
  prefix = local.prefix
  tags   = local.common_tags
}

module "tasks_dynamodb_table" {
  source = "./modules/dynamodb"

  prefix     = local.prefix
  table_name = "tasks"
  tags       = local.common_tags
}

module "tasks_sqs_queue" {
  source = "./modules/sqs"

  name                      = "${local.prefix}-tasks"
  allowed_items_max         = 50
  message_retention_seconds = 1600
  allowed_arns = [
    module.service_api.task_role_arn,
    module.service_task_runner.task_role_arn,
  ]

  max_task_receive_count     = 3
  visibility_timeout_seconds = 60
  alarm_sns_topic_arn        = var.slack_webhook_url != null ? module.sns_slack_topic[0].sns_topic_arn : null

  tags = local.common_tags
}

module "service_api" {
  source = "./modules/ecs/services/api"
  prefix = local.prefix

  vpc_id                      = module.network.vpc_id
  private_subnets             = module.network.private_subnets[*].id
  public_subnets              = module.network.public_subnets[*].id
  private_subnets_cidr_blocks = module.network.private_subnets[*].cidr_block
  certificate_arn             = module.certificates.eu_west_region_arn
  tasks_dynamodb_table_arn    = module.tasks_dynamodb_table.table_arn
  tasks_dynamodb_table_name   = module.tasks_dynamodb_table.table_name

  ecs_cluster_id     = module.ecs.ecs_cluster_id
  ecs_cluster_name   = module.ecs.ecs_cluster_name
  task_definition    = var.ecs_service_api_task_definition
  task_queue_sqs_url = module.tasks_sqs_queue.queue_url

  tags = local.common_tags
}

module "service_task_runner" {
  source = "./modules/ecs/services/task-runner"
  prefix = local.prefix

  vpc_id                      = module.network.vpc_id
  private_subnets             = module.network.private_subnets[*].id
  private_subnets_cidr_blocks = module.network.private_subnets[*].cidr_block
  tasks_dynamodb_table_arn    = module.tasks_dynamodb_table.table_arn
  tasks_dynamodb_table_name   = module.tasks_dynamodb_table.table_name

  ecs_cluster_id             = module.ecs.ecs_cluster_id
  ecs_cluster_name           = module.ecs.ecs_cluster_name
  task_definition            = var.ecs_service_task_runner_task_definition
  task_queue_sqs_url         = module.tasks_sqs_queue.queue_url
  autoscale_alert_sns_topics = var.slack_webhook_url != null ? [module.sns_slack_topic[0].sns_topic_arn] : []

  tags = local.common_tags
}

module "frontend_app" {
  source = "./modules/frontend"

  prefix = local.prefix
  tags   = local.common_tags
}

module "cloudfront" {
  source = "./modules/cloudfront"

  prefix                    = local.prefix
  alb_domain_name           = module.service_api.alb_domain_name
  dns_prefix                = "${terraform.workspace}.${var.domain_name}"
  certificate_arn           = module.certificates.us_east_region_arn
  frontend_s3_bucket_arn    = module.frontend_app.s3_bucket_arn
  frontend_s3_bucket_id     = module.frontend_app.s3_bucket_id
  frontend_s3_bucket_domain = module.frontend_app.s3_bucket_domain

  tags = local.common_tags
}