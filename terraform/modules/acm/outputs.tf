output "eu_west_region_arn" {
  value = data.aws_acm_certificate.eu_west_region.arn
}

output "us_east_region_arn" {
  value = data.aws_acm_certificate.us_east_region.arn
}