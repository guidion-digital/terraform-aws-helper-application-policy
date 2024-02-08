data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "this" {
  statement {
    sid       = "logs0"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/*/${var.application_name}-*:*"]
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup"
    ]
  }

  statement {
    sid       = "logs1"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/*/${var.application_name}-*:*:*"]
    actions   = ["logs:PutLogEvents"]
  }

  dynamic "statement" {
    for_each = var.sqs_queues != null ? [var.sqs_queues] : []

    content {
      sid       = "sqslist"
      effect    = "Allow"
      resources = ["*"]
      actions   = ["sqs:ListQueues"]
    }
  }

  dynamic "statement" {
    for_each = var.sqs_queues != null ? [var.sqs_queues] : []

    content {
      sid       = "sqsrw"
      effect    = "Allow"
      resources = var.sqs_queues
      actions = [
        "sqs:DeleteMessage",
        "sqs:ListQueues",
        "sqs:GetQueueUrl",
        "sqs:ListDeadLetterSourceQueues",
        "sqs:CancelMessageMoveTask",
        "sqs:ChangeMessageVisibility",
        "sqs:ListMessageMoveTasks",
        "sqs:PurgeQueue",
        "sqs:ReceiveMessage",
        "sqs:SendMessage",
        "sqs:GetQueueAttributes",
        "sqs:ListQueueTags"
      ]
    }
  }

  dynamic "statement" {
    for_each = var.dynamodb_tables != null ? [var.dynamodb_tables] : []

    content {
      sid       = "dynamodblist"
      effect    = "Allow"
      resources = ["*"]
      actions = [
        "dynamodb:ListContributorInsights",
        "dynamodb:ListGlobalTables",
        "dynamodb:ListTables",
        "dynamodb:ListBackups",
        "dynamodb:ListImports",
        "dynamodb:ListExports",
        "dynamodb:DescribeReservedCapacity",
        "dynamodb:DescribeLimits"
      ]
    }
  }

  dynamic "statement" {
    for_each = var.dynamodb_tables != null ? [var.dynamodb_tables] : []

    content {
      sid       = "dynamodbwrite"
      effect    = "Allow"
      resources = var.dynamodb_tables
      actions = [
        "dynamodb:DescribeContributorInsights",
        "dynamodb:BatchGetItem",
        "dynamodb:BatchWriteItem",
        "dynamodb:UpdateTimeToLive",
        "dynamodb:ConditionCheckItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem",
        "dynamodb:Scan",
        "dynamodb:ListTagsOfResource",
        "dynamodb:Query",
        "dynamodb:DescribeStream",
        "dynamodb:UpdateItem",
        "dynamodb:DescribeTimeToLive",
        "dynamodb:PartiQLSelect",
        "dynamodb:DescribeTable",
        "dynamodb:GetShardIterator",
        "dynamodb:PartiQLInsert",
        "dynamodb:GetItem",
        "dynamodb:GetRecords",
        "dynamodb:PartiQLDelete"
      ]
    }
  }
}

resource "aws_iam_policy" "this" {
  name   = "${var.application_name}-services"
  path   = "/application/"
  policy = data.aws_iam_policy_document.this.json
}
