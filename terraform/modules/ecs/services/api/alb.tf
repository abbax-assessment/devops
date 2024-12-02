
resource "aws_alb" "this" {
  name            = "${var.prefix}-${var.app_name}-alb"
  subnets         = var.public_subnets
  security_groups = [aws_security_group.alb.id]
  tags            = var.tags
}

resource "aws_security_group" "alb" {
  description = "Allow access to the api load balancer"
  name        = "${var.prefix}-${var.app_name}-alb-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = var.private_subnets_cidr_blocks
  }

  // ALB most respond to ANY ip   
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"] //tfsec:ignore:aws-vpc-no-public-egress-sg
  }

  tags = merge(
    tomap({ "Name" = "${var.prefix}-${var.app_name}-alb-sg" }),
    var.tags
  )
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
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.blue.arn
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [default_action]
  }
}