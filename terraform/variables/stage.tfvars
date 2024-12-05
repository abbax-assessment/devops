domain_name = "deveros.click"
prefix      = "tsk"

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


