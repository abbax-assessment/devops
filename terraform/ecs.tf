module "ecs" {
  source = "./services/ecs"
  prefix = local.prefix
  tags   = local.common_tags
}

module "service_api" {
  source = "./services/ecs/services/api"
  prefix = var.prefix

  ecs_cluster_id  = module.ecs.ecs_cluster_id
  private_subnets = module.network.private_subnets[*].id
  task_definition = var.ecs_service_api_task_definition

  tags = local.common_tags
}