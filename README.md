## Requirements

| Name | Version    |
|------|------------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | \>= 5.58.0 |

## Providers

| Name | Version    |
|------|------------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | \>= 5.58.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_docdb_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster) | resource |
| [aws_docdb_cluster_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_instance) | resource |
| [aws_docdb_cluster_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_parameter_group) | resource |
| [aws_docdb_cluster_snapshot.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_snapshot) | resource |
| [aws_docdb_event_subscription.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_event_subscription) | resource |
| [aws_docdb_global_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_global_cluster) | resource |
| [aws_docdb_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_subnet_group) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/db_subnet_group) | data source |
| [aws_default_tags.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnet_ids.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | n/a | <pre>list(object({<br>    id                              = number<br>    allow_major_version_upgrade     = optional(bool)<br>    apply_immediately               = optional(bool)<br>    availability_zones              = optional(list(string))<br>    backup_retention_period         = optional(number)<br>    cluster_identifier              = optional(string)<br>    cluster_identifier_prefix       = optional(string)<br>    db_cluster_parameter_group_name = optional(string)<br>    db_subnet_group_name            = optional(string)<br>    deletion_protection             = optional(bool)<br>    enabled_cloudwatch_logs_exports = optional(list(string))<br>    final_snapshot_identifier       = optional(string)<br>    global_cluster_id               = optional(number)<br>    kms_key_id                      = optional(string)<br>    master_password                 = optional(string)<br>    master_username                 = optional(string)<br>    port                            = optional(number)<br>    preferred_backup_window         = optional(string)<br>    preferred_maintenance_window    = optional(string)<br>    skip_final_snapshot             = optional(bool)<br>    snapshot_identifier             = optional(string)<br>    storage_encrypted               = optional(bool)<br>    storage_type                    = optional(string)<br>    tags                            = optional(map(string))<br>    vpc_security_group_ids          = optional(list(string))<br>    restore_to_point_in_time = optional(list(object({<br>      source_cluster_identifier  = optional(string)<br>      restore_to_time            = optional(string)<br>      restore_type               = optional(string)<br>      use_latest_restorable_time = optional(bool)<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_cluster_instance"></a> [cluster\_instance](#input\_cluster\_instance) | n/a | <pre>list(object({<br>    id                           = number<br>    cluster_id                   = number<br>    instance_class               = string<br>    apply_immediately            = optional(bool)<br>    auto_minor_version_upgrade   = optional(bool)<br>    availability_zone            = optional(string)<br>    ca_cert_identifier           = optional(string)<br>    copy_tags_to_snapshot        = optional(bool)<br>    enable_performance_insights  = optional(bool)<br>    identifier                   = optional(string)<br>    identifier_prefix            = optional(string)<br>    kms_key_id                   = optional(number)<br>    preferred_maintenance_window = optional(string)<br>    promotion_tier               = optional(number)<br>    global_cluster_id            = optional(number)<br>    tags                         = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_cluster_parameter_group"></a> [cluster\_parameter\_group](#input\_cluster\_parameter\_group) | n/a | <pre>list(object({<br>    id          = number<br>    family      = optional(string)<br>    description = optional(string)<br>    name        = optional(string)<br>    name_prefix = optional(string)<br>    tags        = optional(map(string))<br>    parameter = optional(list(object({<br>      name  = string<br>      value = string<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_cluster_snapshot"></a> [cluster\_snapshot](#input\_cluster\_snapshot) | n/a | <pre>list(object({<br>    id                             = number<br>    db_cluster_id                  = number<br>    db_cluster_snapshot_identifier = string<br>  }))</pre> | `[]` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_event_subscription"></a> [event\_subscription](#input\_event\_subscription) | n/a | <pre>list(object({<br>    id               = number<br>    sns_topic_id     = optional(number)<br>    enabled          = optional(bool)<br>    event_categories = optional(list(string))<br>    name             = optional(string)<br>    name_prefix      = optional(string)<br>    source_ids       = optional(list(number))<br>    source_type      = optional(string)<br>    tags             = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_global_cluster"></a> [global\_cluster](#input\_global\_cluster) | n/a | <pre>list(object({<br>    id                        = number<br>    global_cluster_identifier = optional(string)<br>    database_name             = optional(string)<br>    deletion_protection       = optional(bool)<br>    engine                    = optional(string)<br>    engine_version            = optional(string)<br>    source_db_cluster_id      = optional(number)<br>    storage_encrypted         = optional(bool)<br>    global_cluster_members = optional(list(object({<br>      db_cluster_id = optional(number)<br>      is_writer     = optional(bool)<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_kms_key"></a> [kms\_key](#input\_kms\_key) | n/a | <pre>list(object({<br>    id                                 = number<br>    bypass_policy_lockout_safety_check = optional(bool)<br>    custom_key_store_id                = optional(string)<br>    customer_master_key_spec           = optional(string)<br>    deletion_window_in_days            = optional(number)<br>    enable_key_rotation                = optional(bool)<br>    is_enabled                         = optional(bool)<br>    key_usage                          = optional(string)<br>    multi_region                       = optional(bool)<br>    policy                             = optional(string)<br>    rotation_period_in_days            = optional(number)<br>    tags                               = optional(map(string))<br>    xks_key_id                         = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | n/a | `string` | `null` | no |
| <a name="input_sns_topic"></a> [sns\_topic](#input\_sns\_topic) | n/a | <pre>list(object({<br>    id                                       = number<br>    application_failure_feedback_role_arn    = optional(string)<br>    application_success_feedback_role_arn    = optional(string)<br>    application_success_feedback_sample_rate = optional(number)<br>    archive_policy                           = optional(string)<br>    content_based_deduplication              = optional(bool)<br>    delivery_policy                          = optional(string)<br>    display_name                             = optional(string)<br>    fifo_topic                               = optional(bool)<br>    firehose_id                              = optional(number)<br>    http_failure_feedback_role_arn           = optional(string)<br>    http_success_feedback_role_arn           = optional(string)<br>    http_success_feedback_sample_rate        = optional(number)<br>    kms_master_key_id                        = optional(number)<br>    lambda_id                                = optional(number)<br>    name                                     = optional(string)<br>    name_prefix                              = optional(string)<br>    policy                                   = optional(string)<br>    signature_version                        = optional(number)<br>    sqs_id                                   = optional(number)<br>    tags                                     = optional(map(string))<br>    tracing_config                           = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_subnet_group"></a> [subnet\_group](#input\_subnet\_group) | n/a | <pre>list(object({<br>    id          = number<br>    subnet_ids  = list(string)<br>    name        = optional(string)<br>    name_prefix = optional(string)<br>    tags        = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_docdb_cluster_arn"></a> [docdb\_cluster\_arn](#output\_docdb\_cluster\_arn) | n/a |
| <a name="output_docdb_cluster_id"></a> [docdb\_cluster\_id](#output\_docdb\_cluster\_id) | n/a |
| <a name="output_docdb_cluster_instance_arn"></a> [docdb\_cluster\_instance\_arn](#output\_docdb\_cluster\_instance\_arn) | n/a |
| <a name="output_docdb_cluster_instance_id"></a> [docdb\_cluster\_instance\_id](#output\_docdb\_cluster\_instance\_id) | n/a |
| <a name="output_docdb_global_cluster_arn"></a> [docdb\_global\_cluster\_arn](#output\_docdb\_global\_cluster\_arn) | n/a |
| <a name="output_docdb_global_cluster_id"></a> [docdb\_global\_cluster\_id](#output\_docdb\_global\_cluster\_id) | n/a |
