resource "aws_docdb_cluster" "this" {
  count                           = length(var.cluster)
  allow_major_version_upgrade     = lookup(var.cluster[count.index], "allow_major_version_upgrade")
  apply_immediately               = lookup(var.cluster[count.index], "apply_immediately")
  availability_zones              = lookup(var.cluster[count.index], "availability_zones")
  backup_retention_period         = lookup(var.cluster[count.index], "backup_retention_period")
  cluster_identifier              = lookup(var.cluster[count.index], "cluster_identifier")
  cluster_identifier_prefix       = lookup(var.cluster[count.index], "cluster_identifier_prefix")
  db_cluster_parameter_group_name = lookup(var.cluster[count.index], "db_cluster_parameter_group_name")
  db_subnet_group_name            = data.aws_db_subnet_group.this.name
  deletion_protection             = lookup(var.cluster[count.index], "deletion_protection")
  enabled_cloudwatch_logs_exports = lookup(var.cluster[count.index], "enabled_cloudwatch_logs_exports", ["audit", "profiler"])
  engine                          = lookup(var.cluster[count.index], "engine")
  engine_version                  = lookup(var.cluster[count.index], "engine_version")
  final_snapshot_identifier       = lookup(var.cluster[count.index], "final_snapshot_identifier")
  global_cluster_identifier       = lookup(var.cluster[count.index], "global_cluster_identifier")
  kms_key_id                      = try(
    element(aws_kms_key.this.*.id, lookup(var.cluster[count.index], "kms_key_id"))
  )
  master_password                 = sensitive(lookup(var.cluster[count.index], "master_password"))
  master_username                 = sensitive(lookup(var.cluster[count.index], "master_username"))
  port                            = lookup(var.cluster[count.index], "port")
  preferred_backup_window         = lookup(var.cluster[count.index], "preferred_backup_window")
  preferred_maintenance_window    = lookup(var.cluster[count.index], "preferred_maintenance_window")
  skip_final_snapshot             = lookup(var.cluster[count.index], "skip_final_snapshot")
  snapshot_identifier             = lookup(var.cluster[count.index], "snapshot_identifier")
  storage_encrypted               = lookup(var.cluster[count.index], "storage_encrypted")
  storage_type                    = lookup(var.cluster[count.index], "storage_type")
  tags                            = merge(
    var.tags,
    lookup(var.cluster[count.index], "tags"),
    data.aws_default_tags.this.tags
  )
  vpc_security_group_ids          = [data.aws_security_group.this.id]

  dynamic "restore_to_point_in_time" {
    for_each = lookup(var.cluster[count.index], "restore_to_point_in_time") == null ? [] : ["restore_to_point_in_time"]
    content {
      source_cluster_identifier  = lookup(restore_to_point_in_time.value, "source_cluster_identifier")
      restore_to_time            = lookup(restore_to_point_in_time.value, "restore_to_time")
      restore_type               = lookup(restore_to_point_in_time.value, "restore_type")
      use_latest_restorable_time = lookup(restore_to_point_in_time.value, "use_latest_restorable_time")
    }
  }
}

resource "aws_docdb_cluster_instance" "this" {
  count                           = length(var.cluster) == 0 ? 0 : length(var.cluster_instance)
  cluster_identifier              = ""
  instance_class                  = ""
  apply_immediately               = true
  auto_minor_version_upgrade      = true
  availability_zone               = ""
  ca_cert_identifier              = ""
  copy_tags_to_snapshot           = true
  enable_performance_insights     = true
  engine                          = ""
  identifier                      = ""
  identifier_prefix               = ""
  performance_insights_kms_key_id = ""
  preferred_maintenance_window    = ""
  promotion_tier                  = 0
  tags                            = {}
}

resource "aws_docdb_cluster_parameter_group" "this" {
  count       = length(var.cluster_parameter_group)
  family      = lookup(var.cluster_parameter_group[count.index], "family")
  description = lookup(var.cluster_parameter_group[count.index], "description")
  name        = lookup(var.cluster_parameter_group[count.index], "name")
  name_prefix = lookup(var.cluster_parameter_group[count.index], "name_prefix")
  tags        = merge(
    var.tags,
    lookup(var.cluster_parameter_group[count.index], "tags"),
    data.aws_default_tags.this.tags
  )

  dynamic "parameter" {
    for_each = lookup(var.cluster_parameter_group[count.index], "parameter") == null ? [] : ["parameter"]
    content {
      name  = lookup(parameter.value, "name")
      value = lookup(parameter.value, "value")
    }
  }
}

resource "aws_docdb_cluster_snapshot" "this" {
  count                          = length(var.cluster) == 0 ? 0 : length(var.cluster_snapshot)
  db_cluster_identifier          = try(
    element(aws_docdb_cluster.this.*.id, lookup(var.cluster_snapshot[count.index], "db_cluster_id"))
  )
  db_cluster_snapshot_identifier = lookup(var.cluster_snapshot[count.index], "db_cluster_snapshot_identifier")
}

resource "aws_docdb_event_subscription" "this" {
  count            = length(var.sns_topic) == 0 ? 0 : length(var.event_subscription)
  sns_topic_arn    = ""
  enabled          = true
  event_categories = []
  name             = ""
  name_prefix      = ""
  source_ids       = []
  source_type      = ""
  tags             = {}
}

resource "aws_docdb_global_cluster" "this" {
  count                        = length(var.global_cluster)
  global_cluster_identifier    = ""
  database_name                = ""
  deletion_protection          = true
  engine                       = ""
  engine_version               = ""
  source_db_cluster_identifier = ""
  storage_encrypted            = true

  dynamic "global_cluster_members" {
    for_each = ""
    content {
      db_cluster_arn = ""
      is_writer      = true
    }
  }
}

resource "aws_docdb_subnet_group" "this" {
  count       = length(var.subnet_group)
  subnet_ids  = []
  name        = ""
  name_prefix = ""
  tags        = {}
}