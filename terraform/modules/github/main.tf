
locals {
  repo_variables_flatten = flatten([
    for repo in var.repos : [
      for variable in repo.variables : {
        path        = repo.path
        environment   = repo.environment
        variable_name = variable.name
        variable_value = variable.value
      }
    ]
  ])
}
resource "github_repository_environment" "this" {
  for_each = { for repo in var.repos : 
    "${repo.path}-${repo.environment}" => repo }

  repository = each.value.path
  environment  = each.value.environment
}

resource "github_actions_environment_variable" "this" {
  for_each = {for repo_vars in local.repo_variables_flatten: 
  "${repo_vars.path}_${repo_vars.environment}_${repo_vars.variable_name}" => repo_vars
  }

  repository  = each.value.path
  environment = each.value.environment
  variable_name = each.value.variable_name
  value = each.value.variable_value

  depends_on = [ github_repository_environment.this ]
}