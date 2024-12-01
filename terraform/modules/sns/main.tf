resource "aws_sns_topic" "this" {
  name = "${var.prefix}-slack-notifications"
  tags = var.tags
}

resource "aws_sns_topic_subscription" "this" {
  topic_arn              = aws_sns_topic.this.arn
  endpoint_auto_confirms = false
  
  protocol = "https"
  endpoint = var.slack_webhook_url
}