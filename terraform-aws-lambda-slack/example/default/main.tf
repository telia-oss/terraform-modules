module "lambda-slack" {
  source           = "../.."
  
  topic_name = "lambda-to-slack"

  lambda_s3_bucket = "s3-bucket-name"

  name_prefix = "name-prefix"

  handler = "main"

  slack_hook = "https://hooks.slack.com/services/Secret"

}
