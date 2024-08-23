module "user_permissions" {
  source = "../../"

  # Name must match application_name you give the application in it's TFE
  # workspace module "applications" entry
  application_name = "example"
  dynamodb_tables  = ["arn:aws:dynamodb:uu-west-1:123456789012:table/myDynamoDBTable"]
  sqs_queues       = ["arn:aws:sqs:eu-west-1:123456789012:my-queue-name"]
}
