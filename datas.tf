data "aws_default_tags" "this" {}

data "aws_db_subnet_group" "this" {
  count = var.db_subnet_group_name ? 1 : 0
  name  = var.db_subnet_group_name
}

data "aws_vpc" "this" {
  count = var.vpc_id ? 1 : 0
  id    = var.vpc_id
}

data "aws_subnet_ids" "this" {
  count = var.vpc_id ? 1 : 0
  vpc_id = data.aws_vpc.this.id
}

data "aws_security_group" "this" {
  count = var.security_group_id ? 1 : 0
  id    = var.security_group_id
}