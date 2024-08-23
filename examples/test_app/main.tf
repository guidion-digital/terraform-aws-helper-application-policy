module "user_permissions" {
  source = "../../"

  # Name must match application_name you give the application in it's TFE
  # workspace module "applications" entry
  application_name = "example"
  dynamodb_tables  = ["arn:aws:dynamodb:eu-central-1:000000000000:table/myDynamoDBTable"]
  sqs_queues       = ["arn:aws:sqs:eu-central-1:000000000000:my-queue-name"]
}
