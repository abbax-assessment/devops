locals {
  aliases                                  = ["${var.dns_prefix}"]
  frontend_origin_id                       = "${var.prefix}-frontend"
  api_origin_id                            = "${var.prefix}-api"
  disabled_caching_policy_id               = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
  forward_all_request_parameters_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
}

module "spa_lambda_edge" {
  source = "./spa-lambda"

  prefix = var.prefix
  tags   = var.tags
}

resource "aws_cloudfront_origin_access_identity" "this" {
  provider = aws.us_east
  comment  = "${var.prefix}-frontend"
}

resource "aws_cloudfront_distribution" "this" {
  provider = aws.us_east
  # frontend origin
  origin {
    domain_name = var.frontend_s3_bucket_domain
    origin_id   = local.frontend_origin_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  # api origin
  origin {
    domain_name = var.alb_domain_name
    origin_id   = local.api_origin_id
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  default_root_object = "index.html"
  aliases             = local.aliases

  default_cache_behavior {
    # Default path pattern (frontend access)
    target_origin_id = local.frontend_origin_id

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD", "OPTIONS"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    lambda_function_association {
      event_type = "origin-request"
      lambda_arn = module.spa_lambda_edge.lambda_arn
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  ordered_cache_behavior {
    # Path behavior will redirect to the api ALB
    target_origin_id = local.api_origin_id

    path_pattern    = "/api/*"
    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods  = ["GET", "HEAD", "OPTIONS"]

    cache_policy_id          = local.disabled_caching_policy_id
    origin_request_policy_id = local.forward_all_request_parameters_policy_id
    viewer_protocol_policy   = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  wait_for_deployment = false

}