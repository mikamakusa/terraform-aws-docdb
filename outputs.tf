output "docdb_cluster_id" {
  value = try(
    aws_docdb_cluster.this.*.id
  )
}

output "docdb_cluster_arn" {
  value = try(
    aws_docdb_cluster.this.*.arn
  )
}

output "docdb_global_cluster_id" {
  value = try(
    aws_docdb_global_cluster.this.*.id
  )
}

output "docdb_global_cluster_arn" {
  value = try(
    aws_docdb_global_cluster.this.*.arn
  )
}

output "docdb_cluster_instance_id" {
  value = try(
    aws_docdb_cluster_instance.this.*.id
  )
}

output "docdb_cluster_instance_arn" {
  value = try(
    aws_docdb_cluster_instance.this.*.arn
  )
}