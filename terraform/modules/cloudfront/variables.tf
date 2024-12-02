variable "prefix" {
  type = string
}

variable "alb_domain_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "frontend_s3_bucket_arn" {
  type = string
}

variable "frontend_s3_bucket_id" {
  type = string
}

variable "frontend_s3_bucket_domain" {
  type = string
}


variable "tags" {
  type = map(any)
}

