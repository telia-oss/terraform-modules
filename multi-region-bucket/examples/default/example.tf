provider "aws" {
  region = "eu-west-1"
}

module "multi-region-bucket" {
  source = "../../"

  name_prefix = "telia-oss-example"
  bucket_acl  = "public-read"

  replication_regions = [
    "eu-west-1",
    "eu-west-2",
  ]
}
