output "queue_url" {
  value = aws_sqs_queue.queue.url
}

output "queue_name" {
  value = aws_sqs_queue.queue.name
}

output "dlq_queue_url" {
  value = aws_sqs_queue.deadletter_queue.url
}

output "dlq_queue_name" {
  value = aws_sqs_queue.deadletter_queue.name
}