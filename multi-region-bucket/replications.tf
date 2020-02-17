# sa-east-1 --------------------------------------------------------------------------
provider "aws" {
  alias  = "sa-east-1"
  region = "sa-east-1"
}

resource "aws_s3_bucket" "sa-east-1" {
  count         = contains(var.replication_regions, "sa-east-1") ? 1 : 0
  provider      = aws.sa-east-1
  bucket        = "${var.name_prefix}-sa-east-1"
  acl           = var.bucket_acl
  force_destroy = true
  tags          = var.tags
}

# ap-south-1 --------------------------------------------------------------------------
provider "aws" {
  alias  = "ap-south-1"
  region = "ap-south-1"
}

resource "aws_s3_bucket" "ap-south-1" {
  count         = contains(var.replication_regions, "ap-south-1") ? 1 : 0
  provider      = aws.ap-south-1
  bucket        = "${var.name_prefix}-ap-south-1"
  acl           = var.bucket_acl
  force_destroy = true
  tags          = var.tags
}

# ap-southeast-2 --------------------------------------------------------------------------
provider "aws" {
  alias  = "ap-southeast-2"
  region = "ap-southeast-2"
}

resource "aws_s3_bucket" "ap-southeast-2" {
  count         = contains(var.replication_regions, "ap-southeast-2") ? 1 : 0
  provider      = aws.ap-southeast-2
  bucket        = "${var.name_prefix}-ap-southeast-2"
  acl           = var.bucket_acl
  force_destroy = true
  tags          = var.tags
}

# ap-southeast-1 --------------------------------------------------------------------------
provider "aws" {
  alias  = "ap-southeast-1"
  region = "ap-southeast-1"
}

resource "aws_s3_bucket" "ap-southeast-1" {
  count         = contains(var.replication_regions, "ap-southeast-1") ? 1 : 0
  provider      = aws.ap-southeast-1
  bucket        = "${var.name_prefix}-ap-southeast-1"
  acl           = var.bucket_acl
  force_destroy = true
  tags          = var.tags
}

# ap-northeast-2 --------------------------------------------------------------------------
provider "aws" {
  alias  = "ap-northeast-2"
  region = "ap-northeast-2"
}

resource "aws_s3_bucket" "ap-northeast-2" {
  count         = contains(var.replication_regions, "ap-northeast-2") ? 1 : 0
  provider      = aws.ap-northeast-2
  bucket        = "${var.name_prefix}-ap-northeast-2"
  acl           = var.bucket_acl
  force_destroy = true
  tags          = var.tags
}

# ap-northeast-1 --------------------------------------------------------------------------
provider "aws" {
  alias  = "ap-northeast-1"
  region = "ap-northeast-1"
}

resource "aws_s3_bucket" "ap-northeast-1" {
  count         = contains(var.replication_regions, "ap-northeast-1") ? 1 : 0
  provider      = aws.ap-northeast-1
  bucket        = "${var.name_prefix}-ap-northeast-1"
  acl           = var.bucket_acl
  force_destroy = true
  tags          = var.tags
}

# eu-west-3 --------------------------------------------------------------------------
provider "aws" {
  alias  = "eu-west-3"
  region = "eu-west-3"
}

resource "aws_s3_bucket" "eu-west-3" {
  count         = contains(var.replication_regions, "eu-west-3") ? 1 : 0
  provider      = aws.eu-west-3
  bucket        = "${var.name_prefix}-eu-west-3"
  acl           = var.bucket_acl
  force_destroy = true
  tags          = var.tags
}

# eu-west-2 --------------------------------------------------------------------------
provider "aws" {
  alias  = "eu-west-2"
  region = "eu-west-2"
}

resource "aws_s3_bucket" "eu-west-2" {
  count         = contains(var.replication_regions, "eu-west-2") ? 1 : 0
  provider      = aws.eu-west-2
  bucket        = "${var.name_prefix}-eu-west-2"
  acl           = var.bucket_acl
  force_destroy = true
  tags          = var.tags
}

# eu-west-1 --------------------------------------------------------------------------
provider "aws" {
  alias  = "eu-west-1"
  region = "eu-west-1"
}

resource "aws_s3_bucket" "eu-west-1" {
  count         = contains(var.replication_regions, "eu-west-1") ? 1 : 0
  provider      = aws.eu-west-1
  bucket        = "${var.name_prefix}-eu-west-1"
  acl           = var.bucket_acl
  force_destroy = true
  tags          = var.tags
}

# eu-central-1 --------------------------------------------------------------------------
provider "aws" {
  alias  = "eu-central-1"
  region = "eu-central-1"
}

resource "aws_s3_bucket" "eu-central-1" {
  count         = contains(var.replication_regions, "eu-central-1") ? 1 : 0
  provider      = aws.eu-central-1
  bucket        = "${var.name_prefix}-eu-central-1"
  acl           = var.bucket_acl
  force_destroy = true
  tags          = var.tags
}

# ca-central-1 --------------------------------------------------------------------------
provider "aws" {
  alias  = "ca-central-1"
  region = "ca-central-1"
}

resource "aws_s3_bucket" "ca-central-1" {
  count         = contains(var.replication_regions, "ca-central-1") ? 1 : 0
  provider      = aws.ca-central-1
  bucket        = "${var.name_prefix}-ca-central-1"
  acl           = var.bucket_acl
  force_destroy = true
  tags          = var.tags
}

# us-west-2 --------------------------------------------------------------------------
provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"
}

resource "aws_s3_bucket" "us-west-2" {
  count         = contains(var.replication_regions, "us-west-2") ? 1 : 0
  provider      = aws.us-west-2
  bucket        = "${var.name_prefix}-us-west-2"
  acl           = var.bucket_acl
  force_destroy = true
  tags          = var.tags
}

# us-west-1 --------------------------------------------------------------------------
provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
}

resource "aws_s3_bucket" "us-west-1" {
  count         = contains(var.replication_regions, "us-west-1") ? 1 : 0
  provider      = aws.us-west-1
  bucket        = "${var.name_prefix}-us-west-1"
  acl           = var.bucket_acl
  force_destroy = true
  tags          = var.tags
}

# us-east-2 --------------------------------------------------------------------------
provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"
}

resource "aws_s3_bucket" "us-east-2" {
  count         = contains(var.replication_regions, "us-east-2") ? 1 : 0
  provider      = aws.us-east-2
  bucket        = "${var.name_prefix}-us-east-2"
  acl           = var.bucket_acl
  force_destroy = true
  tags          = var.tags
}

# us-east-1 --------------------------------------------------------------------------
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

resource "aws_s3_bucket" "us-east-1" {
  count         = contains(var.replication_regions, "us-east-1") ? 1 : 0
  provider      = aws.us-east-1
  bucket        = "${var.name_prefix}-us-east-1"
  acl           = var.bucket_acl
  force_destroy = true
  tags          = var.tags
}
