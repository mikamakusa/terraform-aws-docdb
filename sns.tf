resource "aws_sns_topic" "this" {
  count                                    = length(var.sns_topic)
  archive_policy                           = lookup(var.sns_topic[count.index], "archive_policy")
  content_based_deduplication              = lookup(var.sns_topic[count.index], "content_based_deduplication")
  delivery_policy                          = lookup(var.sns_topic[count.index], "delivery_policy")
  display_name                             = lookup(var.sns_topic[count.index], "display_name")
  fifo_topic                               = lookup(var.sns_topic[count.index], "fifo_topic")
  kms_master_key_id                        = try(
      element(aws_kms_key.this.*.id, lookup(var.sns_topic[count.index], "kms_master_key_id"))
  )
  name                                     = lookup(var.sns_topic[count.index], "name")
  name_prefix                              = lookup(var.sns_topic[count.index], "name_prefix")
  policy                                   = lookup(var.sns_topic[count.index], "policy")
  signature_version                        = lookup(var.sns_topic[count.index], "signature_version")
  tags                                     = merge(
    var.tags,
    lookup(var.sns_topic[count.index], "tags"),
    data.aws_default_tags.this.tags
  )
  tracing_config                           = lookup(var.sns_topic[count.index], "tracing_config")
}