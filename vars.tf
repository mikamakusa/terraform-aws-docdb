variable "tags" {
  type    = map(string)
  default = {}
}

variable "db_subnet_group_name" {
  type    = string
  default = null
}

variable "security_group_id" {
  type    = string
  default = null
}

variable "cluster" {
  type = list(object({
    id                              = number
    allow_major_version_upgrade     = optional(bool)
    apply_immediately               = optional(bool)
    availability_zones              = optional(list(string))
    backup_retention_period         = optional(number)
    cluster_identifier              = optional(string)
    cluster_identifier_prefix       = optional(string)
    db_cluster_parameter_group_name = optional(string)
    db_subnet_group_name            = optional(string)
    deletion_protection             = optional(bool)
    enabled_cloudwatch_logs_exports = optional(list(string))
    engine                          = optional(string)
    engine_version                  = optional(string)
    final_snapshot_identifier       = optional(string)
    global_cluster_identifier       = optional(string)
    kms_key_id                      = optional(string)
    master_password                 = optional(string)
    master_username                 = optional(string)
    port                            = optional(number)
    preferred_backup_window         = optional(string)
    preferred_maintenance_window    = optional(string)
    skip_final_snapshot             = optional(bool)
    snapshot_identifier             = optional(string)
    storage_encrypted               = optional(bool)
    storage_type                    = optional(string)
    tags                            = optional(map(string))
    vpc_security_group_ids          = optional(list(string))
    restore_to_point_in_time = optional(list(object({
      source_cluster_identifier  = optional(string)
      restore_to_time            = optional(string)
      restore_type               = optional(string)
      use_latest_restorable_time = optional(bool)
    })), [])
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "cluster_instance" {
  type = list(object({
    id                              = number
    cluster_id                      = number
    instance_class                  = string
    apply_immediately               = optional(bool)
    auto_minor_version_upgrade      = optional(bool)
    availability_zone               = optional(string)
    ca_cert_identifier              = optional(string)
    copy_tags_to_snapshot           = optional(bool)
    enable_performance_insights     = optional(bool)
    engine                          = optional(string)
    identifier                      = optional(string)
    identifier_prefix               = optional(string)
    performance_insights_kms_key_id = optional(string)
    preferred_maintenance_window    = optional(string)
    promotion_tier                  = optional(number)
    tags                            = optional(map(string))
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "cluster_parameter_group" {
  type = list(object({
    id          = number
    family      = optional(string)
    description = optional(string)
    name        = optional(string)
    name_prefix = optional(string)
    tags        = optional(map(string))
    parameter = optional(list(object({
      name  = string
      value = string
    })), [])
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "cluster_snapshot" {
  type = list(object({
    id                             = number
    db_cluster_id                  = number
    db_cluster_snapshot_identifier = string
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "event_subscription" {
  type = list(object({
    id               = number
    sns_topic_arn    = optional(string)
    enabled          = optional(bool)
    event_categories = optional(list(string))
    name             = optional(string)
    name_prefix      = optional(string)
    source_ids       = optional(list(string))
    source_type      = optional(string)
    tags             = optional(map(string))
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "global_cluster" {
  type = list(object({
    id                           = number
    global_cluster_identifier    = optional(string)
    database_name                = optional(string)
    deletion_protection          = optional(bool)
    engine                       = optional(string)
    engine_version               = optional(string)
    source_db_cluster_identifier = optional(string)
    storage_encrypted            = optional(bool)
    global_cluster_members = optional(list(object({
      db_cluster_arn = optional(string)
      is_writer      = optional(bool)
    })), [])
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "subnet_group" {
  type = list(object({
    id          = number
    subnet_ids  = list(string)
    name        = optional(string)
    name_prefix = optional(string)
    tags        = optional(map(string))
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "sns_topic" {
  type = list(object({
    id                                       = number
    application_failure_feedback_role_arn    = optional(string)
    application_success_feedback_role_arn    = optional(string)
    application_success_feedback_sample_rate = optional(number)
    archive_policy                           = optional(string)
    content_based_deduplication              = optional(bool)
    delivery_policy                          = optional(string)
    display_name                             = optional(string)
    fifo_topic                               = optional(bool)
    firehose_failure_feedback_role_arn       = optional(string)
    firehose_success_feedback_role_arn       = optional(string)
    firehose_success_feedback_sample_rate    = optional(number)
    http_failure_feedback_role_arn           = optional(string)
    http_success_feedback_role_arn           = optional(string)
    http_success_feedback_sample_rate        = optional(number)
    kms_master_key_id                        = optional(string)
    lambda_failure_feedback_role_arn         = optional(string)
    lambda_success_feedback_role_arn         = optional(string)
    lambda_success_feedback_sample_rate      = optional(number)
    name                                     = optional(string)
    name_prefix                              = optional(string)
    policy                                   = optional(string)
    signature_version                        = optional(number)
    sqs_failure_feedback_role_arn            = optional(string)
    sqs_success_feedback_role_arn            = optional(string)
    sqs_success_feedback_sample_rate         = optional(number)
    tags                                     = optional(map(string))
    tracing_config                           = optional(string)
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "kms_key" {
  type = list(object({
    id                                 = number
    bypass_policy_lockout_safety_check = optional(bool)
    custom_key_store_id                = optional(string)
    customer_master_key_spec           = optional(string)
    deletion_window_in_days            = optional(number)
    enable_key_rotation                = optional(bool)
    is_enabled                         = optional(bool)
    key_usage                          = optional(string)
    multi_region                       = optional(bool)
    policy                             = optional(string)
    rotation_period_in_days            = optional(number)
    tags                               = optional(map(string))
    xks_key_id                         = optional(string)
  }))
  default     = []
  description = <<EOF
  EOF
}