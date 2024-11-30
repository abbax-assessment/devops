resource "aws_security_group" "alb" {
  description = "Allow access to the api load balancer"
  name        = "${var.prefix}-${var.app_name}-alb-sg"
  vpc_id      = var.vpc_id

  tags = merge(
    tomap({ "Name" = "${var.prefix}-${var.app_name}-alb-sg" }),
    var.tags
  )
}


resource "aws_vpc_security_group_ingress_rule" "public_access" {
  security_group_id = aws_security_group.alb.id
  description = "Allow public access"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "service_access" {
  security_group_id = aws_security_group.alb.id
  description = "Allow access from api ecs service"

  referenced_security_group_id = aws_security_group.service.id
  from_port                    = var.port
  to_port                      = var.port
  ip_protocol                  = "tcp"
}


resource "aws_alb" "this" {
  name            = "${var.prefix}-${var.app_name}-alb"
  subnets         = var.public_subnets
  security_groups = [aws_security_group.alb.id]
  tags            = var.tags
}

resource "aws_alb_target_group" "blue" {
  name                 = "${var.prefix}-${var.app_name}-blue-tg"
  port                 = var.port
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  target_type          = "ip"
  deregistration_delay = 5

  health_check {
    healthy_threshold   = 2
    interval            = 5
    protocol            = "HTTP"
    matcher             = 200
    timeout             = 3
    path                = "/health-check"
    unhealthy_threshold = 3
  }
}

resource "aws_alb_target_group" "green" {
  name        = "${var.prefix}-${var.app_name}-green-tg"
  port        = var.port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = 3
    interval            = 30
    protocol            = "HTTP"
    matcher             = 200
    timeout             = 3
    path                = "/health-check"
    unhealthy_threshold = 2
  }
}

resource "aws_alb_listener" "default_https" {
  load_balancer_arn = aws_alb.this.arn
  port              = 80
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  # TODO certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.blue.arn
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [default_action]
  }
}