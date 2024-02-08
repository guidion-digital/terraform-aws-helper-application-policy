# Global variables
variables {
  application_name     = "megapp"

  sqs_queues = ["arn:aws:sqs:*:*:megapp-*"]
  dynamodb_tables = [
    "arn:aws:dynamodb:*:*:table/megapp-*",
    "arn:aws:dynamodb:*:*:table/megapp-*/stream/*",
    "arn:aws:dynamodb:*:*:table/megapp-*/*/*",
    "arn:aws:dynamodb:*:*:table/megapp/stream/*"
  ]
}

run "policy_created" {
  module {
    source = "./examples/test_app"
  }

  command = apply

  variables {
    application_name     = var.application_name
    dynamodb_tables      = var.dynamodb_tables
    sqs_queues           = var.sqs_queues
  }

  assert {
    condition = module.user_permissions.policy_arn != null
    error_message = "A policy was not generated"
  }
}
