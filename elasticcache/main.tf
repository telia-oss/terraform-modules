# Documentation
# https://www.terraform.io/docs/providers/aws/r/elasticache_cluster.html

resource "aws_elasticache_subnet_group" "main" {
  name       = "main"
  subnet_ids = ["${var.subnet_ids}"]
}

resource "aws_elasticache_cluster" "main" {
  subnet_group_name    = "${aws_elasticache_subnet_group.main.name}"
  security_group_ids   = ["${aws_security_group.main.id}"]
  cluster_id           = "${var.prefix}"
  parameter_group_name = "${var.parameter_group_name}"
  engine               = "${var.engine}"
  node_type            = "${var.node_type}"
  num_cache_nodes      = "${var.num_cache_nodes}"
  az_mode              = "${var.az_mode}"
  port                 = "${var.port}"

  tags = "${var.tags}"
}

resource "aws_security_group" "main" {
  name        = "${var.prefix}-memcached-sg"
  description = "Terraformed security group."
  vpc_id      = "${var.vpc_id}"

  tags = "${merge(var.tags, map("Name", "${var.prefix}-memcached-sg"))}"
}
