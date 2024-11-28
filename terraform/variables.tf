variable "ecs_service_api_task_definition" {
  type = object({
    desired_count = number
    task = object({
      cpu    = number
      memory = number
    })
    app = object({
      cpu    = number
      memory = number
    }),
    xray_sidecar = object({
      cpu    = number
      memory = number
    })
  })
}

variable "ecs_service_task_runner_task_definition" {
  type = object({
    desired_count = number
    task = object({
      cpu    = number
      memory = number
    })
    app = object({
      cpu    = number
      memory = number
    }),
    xray_sidecar = object({
      cpu    = number
      memory = number
    })
    autoscale = object({
      min_capacity           = number
      max_capacity           = number
      max_avg_cpu_percentage = number
      max_avg_ram_percentage = number
    })
  })
}

variable "prefix" {
  type = string
}

variable "notifications_channel_slack_webhook" {
  type = string
}

variable "slack_webhook_url" {
  type    = string
  default = null
}

variable "github_token" {
  type = string  
}