data "aws_vpc" "main" {
  default = true
}

data "aws_subnet_ids" "main" {
  vpc_id = "${data.aws_vpc.main.id}"
}

resource "aws_security_group" "cache_sec_group" {
  name        = "exammple_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${data.aws_vpc.main.id}"
}

module "example_elasticcache_cluster" {
  source                   = "../.."
  prefix                   = "example"
  vpc_id                   = "${data.aws_vpc.main.id}"
  subnet_ids               = "${data.aws_subnet_ids.main.ids}"
  source_security_group_id = "${aws_security_group.cache_sec_group.id}"
}
