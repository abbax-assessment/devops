

resource "aws_grafana_workspace" "this" {
  name = "${var.prefix}-grafana-workspace"
  account_access_type      = "CURRENT_ACCOUNT"
  authentication_providers = ["AWS_SSO"]
  permission_type          = "SERVICE_MANAGED"
  role_arn                 = aws_iam_role.assume.arn

  configuration = jsonencode(
    {
      "plugins" = {
        "pluginAdminEnabled" = true
      },
      "unifiedAlerting" = {
        "enabled" = false
      }
    }
  )

  data_sources = [
    "ATHENA",
    "CLOUDWATCH",
    "XRAY"
  ]

  notification_destinations = ["SNS"]


  grafana_version = "10.4"
  vpc_configuration {
    security_group_ids = [aws_security_group.this.id]
    subnet_ids = var.vpc_subnets
  }
  tags = var.tags
}

resource "aws_grafana_workspace_service_account" "this" {
  name         = "${var.prefix}-tf-admin"
  grafana_role = "ADMIN"
  workspace_id = aws_grafana_workspace.this.id
}

resource "time_rotating" "this" {
  rotation_minutes = 60 * 24 * 30
}

resource "aws_grafana_workspace_service_account_token" "this" {
  name               = "${var.prefix}-tf-admin-key-${time_rotating.this.id}"
  service_account_id = aws_grafana_workspace_service_account.this.service_account_id
  seconds_to_live    = 2592000
  workspace_id       = aws_grafana_workspace.this.id

  depends_on = [ time_rotating.this ]
}


resource "aws_security_group" "this" {
  description = "Allow access to Grafana workspace"
  name        = "${var.prefix}-grafana-sg"
  vpc_id      = var.vpc_id

  tags = merge(
    tomap({ "Name" = "${var.prefix}-grafana-sg" }),
    var.tags
  )
}


resource "aws_vpc_security_group_ingress_rule" "public_access" {
  security_group_id = aws_security_group.this.id
  description       = "Allow public access"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_egress_rule" "public_access" {
  security_group_id = aws_security_group.this.id
  description       = "Allow public access"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}