resource "aws_dynamodb_table" "this" {
  name         = "${var.prefix}-${var.table_name}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "taskId"
  range_key    = "timestamp"

  attribute {
    name = "taskId"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "N"
  }

  server_side_encryption {
    enabled = true
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = merge(
    var.tags,
    tomap({ "Name" = "${var.prefix}-${var.table_name}" })
  )
}