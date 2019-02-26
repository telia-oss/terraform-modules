# Documentation
# https://www.terraform.io/docs/providers/aws/r/elasticache_cluster.html

variable "prefix" {
  description = "A prefix used for naming resources."
  default     = "main"
}

# Engine, enginve_version and parameter_group_name must be coherent.
variable "engine" {
  default = "memcached"
}

variable "engine_version" {
  default = "1.15.10"
}

variable "parameter_group_name" {
  default = "default.memcached1.5"
}

variable "node_type" {
  default = "cache.t2.micro"
}

variable "num_cache_nodes" {
  default = 2
}

variable "az_mode" {
  default = "cross-az"
}

variable "port" {
  default = 11211
}

variable "vpc_id" {
  description = "ID of the VPC for the subnets."
}

variable "subnet_ids" {
  description = "ID of subnets for the elasticca subnet group."
  type        = "list"
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = "map"
  default     = {}
}
