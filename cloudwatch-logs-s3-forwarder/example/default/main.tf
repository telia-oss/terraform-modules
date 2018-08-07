# The key of the map is the cloudwatch log group, the value is the filter syntax expression.
# All matching log entries will be forwarded to a Lambda function, that forwards the entries to
# a shared bucket in the telia-common-logs-prod account.

locals {
  subscriptions = {
    "test" = ""
  }
}

module "cloudwatch_splunk_lambda_subscription" {
  source           = "../.."
  name_prefix      = "sample_log_forwarder"
  log_group_names  = "${keys(local.subscriptions)}"
  filter_patterns  = "${values(local.subscriptions)}"
  lambda_s3_bucket = "artifact-bucket"
  log_bucket_name  = "log-bucket"
}
