data "aws_route53_zone" "public_zone" {
  name = "deveros.click."
}


locals {
  C_NAMES = [
    for record in var.records :
    record if record.type == "CNAME"
  ]

  ALIAS = [
    for record in var.records :
    record if record.type == "A"
  ]
}


resource "aws_route53_record" "c_name_records" {
  for_each = { for record in local.C_NAMES : record.name => record }
  zone_id  = data.aws_route53_zone.public_zone.id
  name     = each.value.dns_name
  records  = each.value.records
  ttl      = 300
  type     = each.value.type
}

resource "aws_route53_record" "alias_records" {
  for_each = { for record in local.ALIAS : record.name => record }
  zone_id  = data.aws_route53_zone.public_zone.id
  name     = each.value.dns_name
  type     = each.value.type

  dynamic "alias" {
    for_each = each.value.type == "A" ? [1] : [] # Ensure this only applies for ALIAS records
    content {
      name                   = each.value.alias_name
      zone_id                = each.value.alias_zone
      evaluate_target_health = true
    }
  }
}