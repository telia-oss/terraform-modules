provider "aws" {
  region = "eu-west-1"
}

module "multi_region_guardduty" {
  source = "../../"

  regions = [
    "eu-west-1",
    "eu-west-2",
  ]
}
