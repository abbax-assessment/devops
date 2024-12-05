resource "aws_ecs_task_definition" "this" {
  family                   = "${local.service_prefix}-task-def"
  execution_role_arn       = aws_iam_role.task_exec_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_definition.task.cpu
  memory                   = var.task_definition.task.memory
  container_definitions = jsonencode([
    {
      name   = var.app_name,
      image  = "nginx",
      cpu    = var.task_definition.app.cpu,
      memory = var.task_definition.app.memory,
      environment = [
        { name : "TASKS_QUEUE_URL", value : var.task_queue_sqs_url },
        { name : "TASKS_DYNAMODB_TABLE", value : var.tasks_dynamodb_table_name },
        { name : "ENVIRONMENT", value : terraform.workspace },
      ]
      essential = true,
      logConfiguration = {
        logDriver : "awslogs",
        options : {
          "awslogs-group" : aws_cloudwatch_log_group.this.name,
          "awslogs-region" : data.aws_region.current.name,
          "awslogs-stream-prefix" : var.app_name
        }
      },

      healthCheck : {
        command : [
          "CMD-SHELL",
          "which nginx || node ./utils/health-check/index.js"
        ],
        interval : 120,
        timeout : 5,
        retries : 3,
        startPeriod : 10
      }
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

  propagate_tags = "NONE"

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [aws_security_group.service.id]
  }

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  depends_on = [
    aws_iam_role.task_role,
    aws_iam_role.task_exec_role
  ]

  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }
}

resource "aws_security_group" "service" {
  description = "Allow access to the service"
  name        = "${var.prefix}-${var.app_name}-service-sg"
  vpc_id      = var.vpc_id

  tags = merge(
    tomap({ "Name" = "${var.prefix}-${var.app_name}-svc-sg" }),
    var.tags
  )
}


resource "aws_vpc_security_group_egress_rule" "private_egress" {
  security_group_id = aws_security_group.service.id
  description       = "Allow access to the internet"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}
