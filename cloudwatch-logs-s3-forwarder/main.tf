resource "aws_iam_role" "lambda_role" {
  name = "${var.name_prefix}_lambda_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "stmtLambdaAssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "allow_lambda_to_log" {
  name        = "${var.name_prefix}_cw_for_lambda"
  description = "Lets the Lambda function write to cloudwatch"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
    ],
      "Resource": [
        "arn:aws:logs:*:*:*"
    ]
  }
 ]
}
EOF
}

resource "aws_iam_policy" "allow_s3_puts" {
  name        = "${var.name_prefix}_s3_for_lambda"
  description = "Lets the Lambda function write to the bucket"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject",
        "s3:PutObjectAcl"
      ],
      "Effect": "Allow",
      "Resource": ["arn:aws:s3:::${var.log_bucket_name}/*"]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_cw_attach" {
  role       = "${aws_iam_role.lambda_role.name}"
  policy_arn = "${aws_iam_policy.allow_lambda_to_log.arn}"
}

resource "aws_iam_role_policy_attachment" "lambda_s3_attach" {
  role       = "${aws_iam_role.lambda_role.name}"
  policy_arn = "${aws_iam_policy.allow_s3_puts.arn}"
}

resource "aws_lambda_function" "bucket_forwarder" {
  s3_bucket     = "${var.lambda_s3_bucket}"
  s3_key        = "${var.s3_key}"
  function_name = "${var.name_prefix}"
  role          = "${aws_iam_role.lambda_role.arn}"
  handler       = "${var.handler}"
  runtime       = "java8"
  timeout       = "${var.timeout}"
  memory_size   = "${var.memory_size}"

  environment {
    variables = {
      bucket_name = "${var.log_bucket_name}"
      split       = "${var.split == 1 ?"true": "false"}"
    }
  }
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.bucket_forwarder.function_name}"
  principal     = "logs.amazonaws.com"
}

resource "aws_cloudwatch_log_subscription_filter" "lambdafunction_logfilters" {
  count           = "${length(var.filter_patterns)}"
  name            = "lambdafunction_logfilter_${element(var.log_group_names, count.index)}"
  log_group_name  = "${element(var.log_group_names, count.index)}"
  filter_pattern  = "${element(var.filter_patterns, count.index)}"
  destination_arn = "${aws_lambda_function.bucket_forwarder.arn}"
}
