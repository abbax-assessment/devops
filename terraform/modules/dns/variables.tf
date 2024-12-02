variable "prefix" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "records" {
  default = []
  type    = any
}

variable "tags" {
  type = map(any)
}