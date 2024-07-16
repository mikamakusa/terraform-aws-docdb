data "aws_default_tags" "this" {}

data "aws_db_subnet_group" "this" {
  count = var.db_subnet_group_name ? 1 : 0
  name  = var.db_subnet_group_name
}

data "aws_security_group" "this" {
  count = var.security_group_id ? 1 : 0
  id    = var.security_group_id
}