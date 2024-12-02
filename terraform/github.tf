module "github" {
  source = "./modules/github"


  prefix       = local.prefix
  github_token = var.github_token

  repos = [
    {
      path = "devops",
      environment : "api-${terraform.workspace}"
      variables : [
        { name : "API_REPO", value : "eros-assessment/api" },
        { name : "API_ECR_NAME", value : module.service_api.ecr_repo_name },
        { name : "API_APP_PORT", value : module.service_api.api_app_port },
        { name : "CODEDEPLOY_APP_NAME_API", value : module.service_api.codedeploy.app_name },
        { name : "CODEDEPLOY_DEPLOYMENT_GROUP_API", value : module.service_api.codedeploy.group_name },
        { name : "CONTAINER_NAME_API", value : module.service_api.container_app_name },
        { name : "ECS_CLUSTER_NAME", value : module.ecs.ecs_cluster_name },
        { name : "ECS_SERVICE_API_NAME", value : module.service_api.ecs_service_name },
        { name : "IMAGE_REGISTRY_URL", value : module.service_api.registry_url },
        { name : "IMAGE_REGISTRY_URL_API", value : module.service_api.ecr_url },
        { name : "TASK_DEF_FAMILY_API", value : module.service_api.task_family_name }
        { name : "TASK_DEF_FAMILY_API", value : module.service_api.task_family_name }

      ]
    },
    {
      path = "devops",
      environment : "task-runner-${terraform.workspace}"
      variables : [
        { name : "TASK_RUNNER_REPO", value : "eros-assessment/task-runner" },
        { name : "CONTAINER_NAME_TASK_RUNNER", value : module.service_task_runner.container_app_name },
        { name : "ECS_CLUSTER_NAME", value : module.ecs.ecs_cluster_name },
        { name : "IMAGE_REGISTRY_URL", value : module.service_api.registry_url },
        { name : "TASK_DEF_FAMILY_TASK_RUNNER", value : module.service_task_runner.task_family_name },
        { name : "TASK_RUNNER_ECR_NAME", value : module.service_task_runner.ecr_repo_name },
        { name : "ECS_SERVICE_TASK_RUNNER_NAME", value : module.service_task_runner.ecs_service_name }
      ]
    },
    {
      path = "devops",
      environment : "frontend-${terraform.workspace}"
      variables : [
        { name : "FRONTEND_REPO", value : "eros-assessment/frontend" },
        { name : "S3_FRONTEND_URL", value : module.frontend_app.s3_bucket_domain },
        { name : "CLOUDFRONT_DISTRIBUTION_ID", value : module.cloudfront.cloudfront_distribution_id },
      ]
    }
  ]


  tags = local.common_tags
}