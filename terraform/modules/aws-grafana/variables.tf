variable "prefix" {
  type = string
}

variable "vpc_subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "tags" {
  type = map(any)
}