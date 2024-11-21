variable "prefix" {
  type = string
}

variable "ecs_cluster_id" {
  type = string
}

variable "task_definition" {
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

variable "private_subnets" {
  type = list(string)
}

variable "tags" {
  type = map(any)
}

