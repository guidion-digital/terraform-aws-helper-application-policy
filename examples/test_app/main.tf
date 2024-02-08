variable "application_name" {}
variable "dynamodb_tables" {}
variable "sqs_queues" {}

module "user_permissions" {
  source = "../../"

  # Name must match application_name you give the application in it's TFE
  # workspace module "applications" entry
  application_name = var.application_name
  dynamodb_tables  = var.dynamodb_tables
  sqs_queues       = var.sqs_queues
}
