run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "cluster_with_global_cluster" {
  command = [init,plan,apply]

  variables {
    global_cluster = [
      {
        id                        = 0
        global_cluster_identifier = "global-test"
        engine                    = "docdb"
        engine_version            = "4.0.0"
      }
    ]
    cluster = [
      {
        id                        = 0
        cluster_identifier        = "primary-cluster"
        master_username           = "admin"
        master_password           = "P@55w0rDoI!"
        global_cluster_id         = 0
        db_subnet_group_name      = "default"
      },
      {
        id                        = 1
        cluster_identifier        = "secondary-cluster"
        master_username           = "admin"
        master_password           = "1T5Aj0k34R!"
        global_cluster_id         = 0
        db_subnet_group_name      = "default"
      }
    ]
    cluster_instance = [
      {
        id                 = 0
        global_cluster_id  = 0
        identifier         = "primary-cluster-instance"
        cluster_id         = 0
        instance_class     = "db.r5.large"
      },
      {
        id                 = 1
        global_cluster_id  = 0
        identifier         = "secondary-cluster-instance"
        cluster_id         = 1
        instance_class     = "db.r5.large"
      }
    ]
    parameter_group = [
      {
        id          = 0
        family      = "docdb3.6"
        name        = "example"
        description = "docdb cluster parameter group"
        parameter = [
          {
            name  = "tls"
            value = "enabled"
          }
        ]
      }
    ]
    cluster_snapshot = [
      {
        id                              = 0
        db_cluster_id                   = 0
        db_cluster_snapshot_identifier  = "snapshot_0"
      },
      {
        id                              = 1
        db_cluster_id                   = 1
        db_cluster_snapshot_identifier  = "snapshot_1"
      }
    ]
  }
}