variable "prefix" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "slack_webhook_url" {
  type = string
}