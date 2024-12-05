variable "prefix" {
  type = string
}

variable "app_name" {
  type    = string
  default = "api"
}

variable "port" {
  type    = number
  default = 3000
}

variable "ecs_cluster_id" {
  type = string
}

variable "ecs_cluster_name" {
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

variable "task_queue_sqs_url" {
  type = string
}

variable "vpc_id" {
  type = string
}
variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "private_subnets_cidr_blocks" {
  type = list(string)
}


variable "tags" {
  type = map(any)
}

variable "certificate_arn" {
  type = string
}

variable "tasks_dynamodb_table_arn" {
  type = string
}

variable "tasks_dynamodb_table_name" {
  type = string
}
