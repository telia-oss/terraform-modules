"""Lambda function for forward content of one bucket to multiple other buckets"""
import ast
import os
import urllib
import boto3

REPLICATION_REGIONS = os.environ.get('REPLICATION_REGIONS')
BUCKET_OBJECT_ACL = os.environ.get('BUCKET_OBJECT_ACL')


def lambda_handler(event, _):
    """Lambda entry point"""
    s3_client = boto3.client('s3')
    sns_message = ast.literal_eval(event['Records'][0]['Sns']['Message'])
    source_bucket = str(sns_message['Records'][0]['s3']['bucket']['name'])
    key = str(urllib.unquote_plus(
        sns_message['Records'][0]['s3']['object']['key']).decode('utf8'))
    copy_source = {'Bucket': source_bucket, 'Key': key}

    for region in REPLICATION_REGIONS.split(','):
        target_bucket = "%s-%s" % (source_bucket, region)
        print 'Copying %s from bucket %s to bucket %s ...' % (key, source_bucket, target_bucket)
        s3_client.copy_object(
            Bucket=target_bucket,
            Key=key,
            CopySource=copy_source,
            ACL=BUCKET_OBJECT_ACL,
        )

    return True
