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
  engine                          = try(
    element(aws_docdb_global_cluster.this.*.engine, lookup(var.cluster[count.index], "global_cluster_id"))
  )
  engine_version                  = try(
    element(aws_docdb_global_cluster.this.*.engine_version, lookup(var.cluster[count.index], "global_cluster_id"))
  )
  final_snapshot_identifier       = lookup(var.cluster[count.index], "final_snapshot_identifier")
  global_cluster_identifier       = try(
    element(aws_docdb_global_cluster.this.*.id, lookup(var.cluster[count.index], "global_cluster_id"))
  )
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
  cluster_identifier              = try(
    element(aws_docdb_cluster.this.*.id, lookup(var.cluster_instance[count.index], "cluster_id"))
  )
  instance_class                  = lookup(var.cluster_instance[count.index], "instance_class")
  apply_immediately               = lookup(var.cluster_instance[count.index], "apply_immediately")
  auto_minor_version_upgrade      = lookup(var.cluster_instance[count.index], "auto_minor_version_upgrade")
  availability_zone               = lookup(var.cluster_instance[count.index], "availability_zone")
  ca_cert_identifier              = lookup(var.cluster_instance[count.index], "ca_cert_identifier")
  copy_tags_to_snapshot           = lookup(var.cluster_instance[count.index], "copy_tags_to_snapshot")
  enable_performance_insights     = lookup(var.cluster_instance[count.index], "enable_performance_insights")
  engine                          = try(
    element(aws_docdb_global_cluster.this.*.engine, lookup(var.cluster_instance[count.index], "global_cluster_id"))
  )
  identifier                      = lookup(var.cluster_instance[count.index], "identifier")
  identifier_prefix               = lookup(var.cluster_instance[count.index], "identifier_prefix")
  performance_insights_kms_key_id = try(
    element(aws_kms_key.this.*.id, lookup(var.cluster_instance[count.index], "kms_key_id"))
  )
  preferred_maintenance_window    = lookup(var.cluster_instance[count.index], "preferred_maintenance_window")
  promotion_tier                  = lookup(var.cluster_instance[count.index], "promotion_tier")
  tags                            = merge(
    var.tags,
    lookup(var.cluster_instance[count.index], "tags"),
    data.aws_default_tags.this.tags
  )
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
  sns_topic_arn    = try(
    element(aws_sns_topic.this.*.arn, lookup(var.event_subscription[count.index], "sns_topic_id"))
  )
  enabled          = lookup(var.event_subscription[count.index], "enabled")
  event_categories = lookup(var.event_subscription[count.index], "event_categories")
  name             = lookup(var.event_subscription[count.index], "name")
  name_prefix      = lookup(var.event_subscription[count.index], "name_prefix")
  source_ids       = try(
    element(aws_docdb_cluster.this.*.id, lookup(var.event_subscription[count.index], "source_ids"))
  )
  source_type      = lookup(var.event_subscription[count.index], "source_type")
  tags             = merge(
    var.tags,
    lookup(var.event_subscription[count.index], "tags"),
    data.aws_default_tags.this.tags
  )
}

resource "aws_docdb_global_cluster" "this" {
  count                        = length(var.global_cluster)
  global_cluster_identifier    = lookup(var.global_cluster[count.index], "global_cluster_identifier")
  database_name                = lookup(var.global_cluster[count.index], "database_name")
  deletion_protection          = lookup(var.global_cluster[count.index], "deletion_protection")
  engine                       = lookup(var.global_cluster[count.index], "engine")
  engine_version               = lookup(var.global_cluster[count.index], "engine_version")
  source_db_cluster_identifier = try(
    element(aws_docdb_cluster.this.*.id, lookup(var.global_cluster[count.index], "source_db_cluster_id"))
  )
  storage_encrypted            = lookup(var.global_cluster[count.index], "storage_encrypted")

  dynamic "global_cluster_members" {
    for_each = lookup(var.global_cluster[count.index], "global_cluster_members") == null ? [] : ["global_cluster_members"]
    content {
      db_cluster_arn = try(
        element(aws_docdb_cluster.this.*.arn, lookup(global_cluster_members.value, "db_cluster_id"))
      )
      is_writer      = lookup(global_cluster_members.value, "is_writer")
    }
  }
}

resource "aws_docdb_subnet_group" "this" {
  count       = var.subnet_group != null && length(var.subnet_group)
  subnet_ids  = data.aws_subnet_ids.this.ids
  name        = lookup(var.subnet_group[count.index], "name")
  name_prefix = lookup(var.subnet_group[count.index], "name_prefix")
  tags        = merge(
    var.tags,
    lookup(var.subnet_group[count.index], "tags"),
    data.aws_default_tags.this.tags
  )
}