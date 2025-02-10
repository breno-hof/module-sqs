resource "aws_sqs_queue" "queue" {
	name                                = var.is_fifo_queue ? "${local.queue_name}.fifo" : local.queue_name

	content_based_deduplication         = var.is_content_based_deduplication_enabled
	deduplication_scope			        = var.is_fifo_queue ? (var.is_deduplication_scope_message_group ? "messageGroup" : "queue") : null
	delay_seconds				        = local.valid_delay_seconds ? var.delay_seconds : 0
	fifo_queue					        = var.is_fifo_queue
	fifo_throughput_limit		        = var.is_fifo_queue ? (var.is_fifo_throughput_limit_per_message_group_id ? "perMessageGroupId" : "perQueue") : null
	kms_data_key_reuse_period_seconds   = var.kms_data_key_reuse_period_seconds
	kms_master_key_id                   = var.kms_master_key_id
	max_message_size                    = local.valid_message_size ? var.max_message_size : 262144
	message_retention_seconds           = local.valid_retention_seconds ? var.message_retention_seconds : 3456000

	policy                              = var.queue_policy

	receive_wait_time_seconds           = local.valid_receive_wait_time ? var.receive_wait_time_seconds : 0

	redrive_policy                      = var.should_handle_deadletters ? jsonencode({
											deadLetterTargetArn = aws_sqs_queue.dlq[0].arn
											maxReceiveCount     = 4
										}) : null

	visibility_timeout_seconds          = local.valid_visibility_timeout ? var.visibility_timeout_seconds : 30
	sqs_managed_sse_enabled             = var.is_sqs_managed_sse_enabled

	tags                                = var.tags
}

resource "aws_sqs_queue" "dlq" {
	count								= var.should_handle_deadletters ? 1 : 0

	name                                = var.is_fifo_queue ? "${local.dlq_queue_name}.fifo" : local.dlq_queue_name

	content_based_deduplication         = var.is_content_based_deduplication_enabled
	deduplication_scope			        = var.is_fifo_queue ? (var.is_deduplication_scope_message_group ? "messageGroup" : "queue") : null
	delay_seconds				        = local.valid_delay_seconds ? var.delay_seconds : 0
	fifo_queue					        = var.is_fifo_queue
	fifo_throughput_limit		        = var.is_fifo_queue ? (var.is_fifo_throughput_limit_per_message_group_id ? "perMessageGroupId" : "perQueue") : null
	kms_data_key_reuse_period_seconds   = var.kms_data_key_reuse_period_seconds
	kms_master_key_id                   = var.kms_master_key_id
	max_message_size                    = local.valid_message_size ? var.max_message_size : 262144
	message_retention_seconds           = local.valid_retention_seconds ? var.message_retention_seconds : 3456000

	policy                              = var.queue_policy

	receive_wait_time_seconds           = local.valid_receive_wait_time ? var.receive_wait_time_seconds : 0
	
	redrive_policy                      = jsonencode({
											deadLetterTargetArn = aws_sqs_queue.error[0].arn
											maxReceiveCount     = 4
										})

	visibility_timeout_seconds          = local.valid_visibility_timeout ? var.visibility_timeout_seconds : 30
	sqs_managed_sse_enabled             = var.is_sqs_managed_sse_enabled

	tags                                = var.tags
}

resource "aws_sqs_queue" "error" {
	count								= var.should_handle_deadletters ? 1 : 0

	name                                = var.is_fifo_queue ? "${local.error_queue_name}.fifo" : local.error_queue_name

	content_based_deduplication         = var.is_content_based_deduplication_enabled
	deduplication_scope			        = var.is_fifo_queue ? (var.is_deduplication_scope_message_group ? "messageGroup" : "queue") : null
	fifo_queue					        = var.is_fifo_queue
	fifo_throughput_limit		        = var.is_fifo_queue ? (var.is_fifo_throughput_limit_per_message_group_id ? "perMessageGroupId" : "perQueue") : null
	kms_data_key_reuse_period_seconds   = var.kms_data_key_reuse_period_seconds
	kms_master_key_id                   = var.kms_master_key_id

	policy                              = var.queue_policy

	sqs_managed_sse_enabled             = var.is_sqs_managed_sse_enabled

	tags                                = var.tags	
}

resource "aws_sqs_queue_redrive_allow_policy" "terraform_queue_redrive_allow_policy" {
	count								= var.should_handle_deadletters ? 1 : 0

	queue_url 							= aws_sqs_queue.dlq[0].id

	redrive_allow_policy 				= jsonencode({
		redrivePermission 				= "byQueue",
		sourceQueueArns   				= [aws_sqs_queue.queue.arn]
	})

	depends_on = [ aws_sqs_queue.dlq, aws_sqs_queue.queue ]
}

resource "aws_sqs_queue_redrive_allow_policy" "terraform_dlq_redrive_allow_policy" {
	count								= var.should_handle_deadletters ? 1 : 0

	queue_url 							= aws_sqs_queue.error[0].id

	redrive_allow_policy 				= jsonencode({
		redrivePermission 				= "byQueue",
		sourceQueueArns   				= [aws_sqs_queue.dlq[0].arn]
	})

	depends_on = [ aws_sqs_queue.dlq, aws_sqs_queue.error ]
}