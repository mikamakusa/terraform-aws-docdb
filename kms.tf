resource "aws_kms_key" "this" {
  bypass_policy_lockout_safety_check = true
  custom_key_store_id                = ""
  customer_master_key_spec           = ""
  deletion_window_in_days            = 0
  enable_key_rotation                = true
  is_enabled                         = true
  key_usage                          = ""
  multi_region                       = true
  policy                             = ""
  rotation_period_in_days            = 0
  tags                               = {}
  xks_key_id                         = ""
}