## Multi region bucket

Easily set up a bucket and have it replicated across multiple regions using a simple Lambda function. Mostly, this module
exists because we need multiple providers to create buckets in regions other than the one set by the provider, and since
this cannot be done with count or any for-loop like syntax, it becomes very verbose.
