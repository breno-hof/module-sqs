output "aws_sqs_queue_arn" {
	description = "ARN of the SQS queue."
	value		= aws_sqs_queue.queue.arn
}

output "aws_sqs_queue_id" {
	description = "URL for the created Amazon SQS queue."
	value		= aws_sqs_queue.queue.id
}

output "aws_sqs_queue_tags" {
	description = "Map of tags assigned to the resource"
	value		= aws_sqs_queue.queue.tags_all  
}

output "aws_sqs_queue_url" {
	description = "Same as id: The URL for the created Amazon SQS queue."
	value		= aws_sqs_queue.queue.url  
}

output "aws_sqs_dlq_arn" {
	description = "ARN of the SQS deadletter queue."
	value		= var.should_handle_deadletters ? aws_sqs_queue.dlq[0].arn : null
}

output "aws_sqs_dlq_id" {
	description = "URL for the created Amazon SQS deadletter queue."
	value		= var.should_handle_deadletters ? aws_sqs_queue.dlq[0].id : null
}

output "aws_sqs_error_arn" {
	description = "ARN of the SQS error queue."
	value		= var.should_handle_deadletters ? aws_sqs_queue.error[0].arn : null
}

output "aws_sqs_error_id" {
	description = "URL for the created Amazon SQS error queue."
	value		= var.should_handle_deadletters ? aws_sqs_queue.error[0].id : null
}