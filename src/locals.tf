locals {
	queue_name					= "${var.queue_name}-queue"
	dlq_queue_name				= "${var.queue_name}-dlq"
	error_queue_name			= "${var.queue_name}-error"

	valid_delay_seconds			= var.delay_seconds >= 0 && var.delay_seconds <= 900
	valid_message_size			= var.max_message_size >= 1024 && var.max_message_size <= 262144
	valid_retention_seconds 	= var.message_retention_seconds >= 60 && var.message_retention_seconds <= 345600
	valid_receive_wait_time		= var.receive_wait_time_seconds >= 0 && var.receive_wait_time_seconds <= 20
	valid_visibility_timeout	= var.visibility_timeout_seconds >= 0 && var.visibility_timeout_seconds <= 43200
}