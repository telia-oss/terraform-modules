# Documentation
# https://www.terraform.io/docs/providers/aws/r/elasticache_cluster.html

output "cache_nodes" {
  value = "${aws_elasticache_cluster.main.cache_nodes}"
}

output "configuration_endpoint" {
  value = "${aws_elasticache_cluster.main.configuration_endpoint}"
}

output "cluster_address" {
  value = "${aws_elasticache_cluster.main.cluster_address}"
}

output "cache_security_group_id" {
  value = "${aws_security_group.main.id}"
}
