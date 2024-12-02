resource "aws_athena_workgroup" "this" {
  name = "${var.prefix}-github-workgroup"

  configuration {
    result_configuration {
      output_location = "s3://${aws_s3_bucket.github_events.bucket}/athena-output/"
    }
  }
}

data "template_file" "init_query" {
  template = file("${path.module}/athena-queries/init.sql.tpl")
  vars = {
    environment = terraform.workspace
    s3_bucket   = aws_s3_bucket.github_events.id
  }
}

locals {
  queries = split(";", data.template_file.init_query.rendered)
}

resource "null_resource" "execute_init_query" {
  count = length(local.queries) - 1

  provisioner "local-exec" {
    command     = <<EOT
      aws athena start-query-execution --work-group ${aws_athena_workgroup.this.name} --query-string "${replace(local.queries[count.index], "\n", "")}"
    EOT
    interpreter = ["PowerShell", "-Command"]
  }
}