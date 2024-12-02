output "cloudfront_distribution_domain" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_distribution_zone_id" {
  value = aws_cloudfront_distribution.this.hosted_zone_id
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.this.id
}

output "aliases" {
  value = local.aliases
}