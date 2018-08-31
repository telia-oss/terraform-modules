resource "aws_sns_topic" "alarm_topic" {
  name = "${var.topic_name}"
}

resource "aws_lambda_function" "notify_slack" {
  s3_bucket     = "${var.lambda_s3_bucket}"
  s3_key        = "${var.s3_key}"
  function_name = "${var.name_prefix}-slack-notify"
  handler       = "${var.handler}"
  runtime       = "go1.x"
  timeout       = "${var.timeout}"
  memory_size   = "${var.memory_size}"
  role          = "${aws_iam_role.lambda_role.arn}"

  environment {
    variables = {
      SLACK_HOOK = "${var.slack_hook}"
      USERNAME = "${var.username}"
      ICON = "${var.icon}"
    }
  }
}

resource "aws_lambda_permission" "allow_sns" {
  statement_id = "AllowExecutionFromSNS"
  action = "lambda:invokeFunction"
  function_name = "${aws_lambda_function.notify_slack.arn}"
  principal = "sns.amazonaws.com"
  source_arn = "${aws_sns_topic.alarm_topic.arn}"
}

resource "aws_sns_topic_subscription" "lambda_sns" {
  topic_arn = "${aws_sns_topic.alarm_topic.arn}"
  protocol = "lambda"
  endpoint = "${aws_lambda_function.notify_slack.arn}"
}
