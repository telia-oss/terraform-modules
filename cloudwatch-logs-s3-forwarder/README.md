# Cloud Watch Log group subscriptions to S3 forwarder

This module lets you forward logs from Cloud Watch Logs to an S3 bucket. 

The module creates Cloud Watch subscriptions for one or more log groups, and targets the subscriptions to a Lambda function that is provisioned by this module. The Lambda function base64 deocdes and decompresses the Cloud Watch payload and moves it to a S3 bucket.

You can use filter expressions to copy only a subset of the log entries, by using the [cloud watch filter syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html)

The lambda can optionally split the cloud watch log event that is a composite JSON object to a list. The variable "split" can be used to trigger this behaviour. 

## Prerequisites  
You need to build and upload the lambda artifact to an S3 bucket  under your control before you apply this module.  [The Lambda artifact can be found here](https://github.com/TeliaSoneraNorge/cloudwatch-subscriptions-s3-writer)
