variable "prefix" {
  type = string
}

variable "github_token" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "task_runner_logs_arn" {
  type = string
}

variable "task_runner_logs_name" {
  type = string
}

variable "api_logs_arn" {
  type = string
}

variable "api_logs_name" {
  type = string
}

variable "task_runner_svc_name" {
  type = string
}

variable "api_svc_name" {
  type = string
}

variable "sqs_tasks_name" {
  type = string
}

variable "alb_arn_suffix" {
  type = string
}

variable "grafana_workspace_url" {
  type = string
}


variable "grafana_service_token" {
  type = string
}


