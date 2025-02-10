variable "is_content_based_deduplication_enabled" {
	description = "(Optional) Enables content-based deduplication for FIFO queues. (default) false."
	type		= bool
	default		= false
}

variable "is_deduplication_scope_message_group" {
	description = "(Optional) Specifies whether message deduplication occurs at the message group or queue level. (default) false."
	type		= bool
	default		= false
}

variable "delay_seconds" {
	description = "(Optional) Time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 seconds."
	type		= number
	default		= 0
}

variable "is_fifo_queue" {
	description = "(Optional) Boolean designating a FIFO queue. If not set, it defaults to false making it standard."
	type		= bool
	default		= false
}

variable "is_fifo_throughput_limit_per_message_group_id" {
	description = "(Optional) Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group. (default) false."
	type		= bool
	default		= false
}

variable "is_sqs_managed_sse_enabled" {
	description = " (Optional) Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys. (default false)."
	type		= bool
	default		= false
}

variable "should_handle_deadletters" {
	description = " (Optional) Should create deadletter queue and error queue. (default false)."
	type		= bool
	default		= true
}


variable "kms_data_key_reuse_period_seconds" {
	description = "(Optional) Length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours). The default is 300 (5 minutes)."
	type		= number
	default		= 300
}

variable "kms_master_key_id" {
	description = "(Optional) ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK."
	type		= string
	default		= null
}

variable "max_message_size" {
	description = "(Optional) Limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB)."
	type		= number
	default		= 262144
}

variable "message_retention_seconds" {
	description = "(Optional) Number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days)."
	type		= number
	default		= 345600
}

variable "queue_name" {
	description = "Name of the queue. Queue names must be made up of only uppercase and lowercase ASCII letters, numbers, underscores, and hyphens, and must be between 1 and 80 characters long."
	type		= string
}

variable "queue_policy" {
	description = "(Optional) JSON policy for the SQS queue."
	type		= string
	default		= null
}

variable "receive_wait_time_seconds" {
	description = "(Optional) Time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately."
	type		= number
	default		= 0
}

variable "visibility_timeout_seconds" {
	description = " (Optional) Visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default for this attribute is 30."
	type		= number
	default		= 30
}

variable "tags" {
	description = "(Optional) Map of tags to assign to the queue."
	type		= map(string)
	default		= {}
}
