variable "prefix" {
  type = string  
}

variable "vpc_subnets" {
  type = list(string)  
}

variable "vpc_id" {
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