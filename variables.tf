variable "application_name" {
  description = "Name of the application"
}

variable "dynamodb_tables" {
  description = "List of full DynamoDB table ARNs"

  type    = list(string)
  default = null
}

variable "sqs_queues" {
  description = "List of full SQS queue ARNs"

  type    = list(string)
  default = null
}
