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
