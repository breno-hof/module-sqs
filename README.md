# AWS SQS Terraform Module

This Terraform module provisions an AWS Simple Queue Service (SQS) queue with configurable attributes.

## Usage

```hcl
module "sqs_queue" {
  source = "github.com/breno-hof/module-sqs//src?ref=1.0.0"

  name                      = "my-sqs-queue"
  visibility_timeout_seconds = 30
  message_retention_seconds  = 345600
  delay_seconds              = 0
  max_message_size           = 262144
  receive_wait_time_seconds  = 0
  is_fifo_queue                 = false
  tags = {
    Environment = "dev"
    Owner       = "your-team"
  }
}
```

## Variables

| Name                          | Type        | Default     | Description |
|--------------------------------|------------|------------|-------------|
| `queue_name`                        | `string`   | N/A        | The name of the SQS queue. |
| `kms_master_key_id`           | `string`   | `null`     | (Optional) ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK. |
| `queue_policy`           | `string`   | `null`     | (Optional) JSON policy for the SQS queue. |
| `visibility_timeout_seconds`   | `number`   | `30`       | The visibility timeout for the queue (in seconds). |
| `kms_data_key_reuse_period_seconds`   | `number`   | `300`       | (Optional) Length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours). |
| `message_retention_seconds`    | `number`   | `345600`   | The number of seconds Amazon SQS retains a message. |
| `delay_seconds`                | `number`   | `0`        | The time in seconds that the delivery of all messages in the queue is delayed. |
| `max_message_size`             | `number`   | `262144`   | The maximum message size in bytes. |
| `receive_wait_time_seconds`    | `number`   | `0`        | The time for which a ReceiveMessage call waits for a message to arrive. |
| `is_fifo_queue`                | `bool`     | `false`    | Whether to create a FIFO (First-In-First-Out) queue. |
| `is_content_based_deduplication_enabled` | `bool`     | `false`    | (Optional) Enables content-based deduplication for FIFO queues. |
| `is_deduplication_scope_message_group` | `bool`     | `false`    | (Optional) Specifies whether message deduplication occurs at the message group or queue level. |
| `is_fifo_throughput_limit_per_message_group_id` | `bool`     | `false`    | (Optional) Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group. |
| `is_sqs_managed_sse_enabled` | `bool`     | `false`    | (Optional) Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys. |
| `should_handle_deadletters` | `bool`     | `false`    | (Optional) Should create deadletter queue and error queue. |
| `tags`                         | `map(string)` | `{}`  | A mapping of tags to assign to the queue. |

## Outputs

| Name                 | Description |
|----------------------|-------------|
| `aws_sqs_queue_id`      | The ID of the created SQS queue. |
| `aws_sqs_queue_arn`     | The ARN of the created SQS queue. |
| `aws_sqs_queue_url`     | The URL of the created SQS queue. |
| `aws_sqs_queue_tags`    | Map of tags assigned to the resource. |
| `aws_sqs_dlq_arn`       | The ARN of the created SQS deadletter queue. |
| `aws_sqs_dlq_id`        | The URL of the created SQS deadletter queue. |
| `aws_sqs_error_arn`     | The ARN of the created SQS error queue. |
| `aws_sqs_error_id`      | The URL of the created SQS error queue. |

## Requirements

- Terraform >= 0.12
- AWS Provider >= 3.0

## License

This project is licensed under the MIT License - see the LICENSE file for details.

