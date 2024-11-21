data "aws_region" "current" {}

locals {
  app_name       = "api"
  port           = 3000
  service_prefix = "${var.prefix}-${local.app_name}"
}

resource "aws_ecr_repository" "this" {
  name                 = "${local.service_prefix}-ecr"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}


resource "aws_cloudwatch_log_group" "this" {
  name = "${local.service_prefix}-logs"
  tags = var.tags
}

resource "aws_cloudwatch_log_group" "xray" {
  name = "${local.service_prefix}-xray-logs"
  tags = var.tags
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${local.service_prefix}-task-def"
  execution_role_arn       = aws_iam_role.task_exec_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_definition.task.cpu
  memory                   = var.task_definition.task.memory
  container_definitions = jsonencode([
    {
      name      = local.app_name,
      image     = "nginx"
      cpu       = var.task_definition.app.cpu,
      memory    = var.task_definition.app.memory,
      essential = true,
      logConfiguration = {
        logDriver : "awslogs",
        options : {
          "awslogs-group" : aws_cloudwatch_log_group.this.name,
          "awslogs-region" : data.aws_region.current.name,
          "awslogs-stream-prefix" : local.app_name
        }
      },
      portMappings : [
        {
          containerPort : local.port,
          hostPort : local.port,
          protocol : "tcp"
        }
      ]
    },
    {
      name      = "xray-sidecar",
      image     = "amazon/aws-xray-daemon",
      cpu       = var.task_definition.xray_sidecar.cpu,
      memory    = var.task_definition.xray_sidecar.memory,
      essential = false,
      logConfiguration = {
        logDriver : "awslogs",
        options : {
          "awslogs-group" : aws_cloudwatch_log_group.xray.name,
          "awslogs-region" : data.aws_region.current.name,
          "awslogs-stream-prefix" : "xray"
        }
      },
      portMappings : [
        {
          containerPort : 2000,
          hostPort : 2000,
          protocol : "udp"
        }
      ]
    },
  ])

  task_role_arn = aws_iam_role.task_role.arn

  tags = var.tags

  depends_on = [
    aws_iam_role.task_role,
    aws_iam_role.task_exec_role
  ]
}

resource "aws_ecs_service" "this" {
  name    = "${local.service_prefix}-svc"
  cluster = var.ecs_cluster_id

  launch_type = "FARGATE"

  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.task_definition.desired_count

  force_new_deployment = false

  propagate_tags = "SERVICE"

  network_configuration {
    subnets = var.private_subnets
    # TODO security_groups = [ "" ]
  }

  depends_on = [
    aws_iam_role.task_role,
    aws_iam_role.task_exec_role
  ]
}