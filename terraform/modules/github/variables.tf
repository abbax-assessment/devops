variable "github_token" {
  type = string
}

variable "repo_variables" {
  type    = list(object({ key : string, value : string }))
  default = []
}

variable "repos" {
  type = list(object({
    path = string
    environment = string
    variables = list(object({
      name = string
      value = string
    }))
  }))
}