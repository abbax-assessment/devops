prefix = "tsk"

ecs_service_api_task_definition = {
  desired_count = 2
  task = {
    cpu    = 512
    memory = 1024
  }
  app = {
    cpu    = 256
    memory = 512
  },
  xray_sidecar = {
    cpu    = 256
    memory = 512
  }
}

ecs_service_task_runner_task_definition = {
  desired_count = 2
  task = {
    cpu    = 512
    memory = 1024
  }
  app = {
    cpu    = 256
    memory = 512
  },
  xray_sidecar = {
    cpu    = 256
    memory = 512
  }
  autoscale = {
    min_capacity           = 2
    max_capacity           = 10
    max_avg_cpu_percentage = 50
    max_avg_ram_percentage = 50
  }
}

notifications_channel_slack_webhook = "https://hooks.slack.com/triggers/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"
grafana_auth                        = ""
grafana_url                         = "https://g-ea3de71a13.grafana-workspace.eu-west-1.amazonaws.com/"