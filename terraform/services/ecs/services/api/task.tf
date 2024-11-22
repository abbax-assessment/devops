resource "aws_ecs_task_definition" "this" {
  family                   = "${local.service_prefix}-task-def"
  execution_role_arn       = aws_iam_role.task_exec_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_definition.task.cpu
  memory                   = var.task_definition.task.memory
  container_definitions = jsonencode([
    {
      name      = var.app_name,
      image     = "569985934894.dkr.ecr.eu-west-1.amazonaws.com/tsk-dev-api-ecr:92e65a7-1732250964" # TODO
      cpu       = var.task_definition.app.cpu,
      memory    = var.task_definition.app.memory,
      essential = true,
      logConfiguration = {
        logDriver : "awslogs",
        options : {
          "awslogs-group" : aws_cloudwatch_log_group.this.name,
          "awslogs-region" : data.aws_region.current.name,
          "awslogs-stream-prefix" : var.app_name
        }
      },
      portMappings : [
        {
          containerPort : var.port,
          hostPort : var.port,
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

  lifecycle {
    ignore_changes = [container_definitions]
  }
}

resource "aws_ecs_service" "this" {
  name    = "${local.service_prefix}-svc"
  cluster = var.ecs_cluster_id

  launch_type = "FARGATE"

  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.task_definition.desired_count

  force_new_deployment = false

  propagate_tags = "SERVICE"

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [aws_security_group.service.id]
  }

  load_balancer {
    container_name   = var.app_name
    container_port   = var.port
    target_group_arn = aws_alb_target_group.blue.arn
  }

  depends_on = [
    aws_iam_role.task_role,
    aws_iam_role.task_exec_role
  ]
}

resource "aws_security_group" "service" {
  description = "Allow access to the service api"
  name        = "${var.prefix}-${var.app_name}-service-sg"
  vpc_id      = var.vpc_id

  tags = merge(
    tomap({ "Name" = "${var.prefix}-${var.app_name}-svc-sg" }),
    var.tags
  )
}

resource "aws_vpc_security_group_ingress_rule" "service" {
  security_group_id = aws_security_group.service.id

  referenced_security_group_id = aws_security_group.alb.id
  from_port                    = var.port
  to_port                      = var.port
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "lb_egress" {
  security_group_id = aws_security_group.service.id

  referenced_security_group_id = aws_security_group.alb.id
  from_port                    = var.port
  to_port                      = var.port
  ip_protocol                  = "tcp"
}


# TODO thelei all traffic
resource "aws_vpc_security_group_egress_rule" "private_egress2" {
  security_group_id = aws_security_group.service.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  to_port     = 0
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "private_egress" {
  security_group_id = aws_security_group.service.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  to_port     = 0
  ip_protocol = "udp"
}