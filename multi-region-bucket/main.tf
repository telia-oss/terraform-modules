# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------
resource "aws_s3_bucket" "main" {
  bucket        = "${var.name_prefix}"
  acl           = "${var.bucket_acl}"
  force_destroy = true
  tags          = "${var.tags}"
}

resource "aws_s3_bucket_notification" "main" {
  bucket = "${aws_s3_bucket.main.id}"

  topic {
    topic_arn = "${aws_sns_topic.main.arn}"
    events    = ["s3:ObjectCreated:*"]
  }

  depends_on = ["aws_s3_bucket.main"]
}

resource "aws_sns_topic" "main" {
  name = "${var.name_prefix}-bucket-notifications"
}

resource "aws_sns_topic_policy" "main" {
  arn    = "${aws_sns_topic.main.arn}"
  policy = "${data.aws_iam_policy_document.topic_policy.json}"
}

data "aws_iam_policy_document" "topic_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "SNS:Publish",
    ]

    resources = [
      "${aws_sns_topic.main.arn}",
    ]

    condition {
      test     = "ArnLike"
      variable = "AWS:SourceArn"

      values = [
        "${aws_s3_bucket.main.arn}",
      ]
    }
  }
}

# ------------------------------------------------------------------------------
# Lambda 
# ------------------------------------------------------------------------------
resource "random_id" "postfix" {
  byte_length = 8
}

data "archive_file" "main" {
  type        = "zip"
  source_file = "${path.module}/lambda.py"
  output_path = "${path.module}/lambda-${random_id.postfix.b64}.zip"
}

module "lambda" {
  source  = "telia-oss/lambda/aws"
  version = "0.3.0"

  name_prefix = "${var.name_prefix}-replicator"
  policy      = "${data.aws_iam_policy_document.lambda_permissions.json}"
  filename    = "${path.module}/lambda-${random_id.postfix.b64}.zip"
  handler     = "lambda.lambda_handler"
  runtime     = "python2.7"

  environment {
    REPLICATION_REGIONS = "${join(",", var.replication_regions)}"
  }

  tags = "${var.tags}"
}

data "aws_iam_policy_document" "lambda_permissions" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.main.arn}/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]

    resources = "${formatlist("arn:aws:s3:::${var.name_prefix}-%s/*", var.replication_regions)}"
  }
}

resource "aws_lambda_permission" "main" {
  depends_on    = ["module.lambda"]
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = "${module.lambda.name}"
  principal     = "sns.amazonaws.com"
  source_arn    = "${aws_sns_topic.main.arn}"
}

resource "aws_sns_topic_subscription" "main" {
  topic_arn = "${aws_sns_topic.main.arn}"
  protocol  = "lambda"
  endpoint  = "${module.lambda.arn}"
}
