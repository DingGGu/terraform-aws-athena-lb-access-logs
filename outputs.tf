output "glue_catalog_database_arn" {
  value = aws_glue_catalog_database.lb_access_log.arn
}

output "glue_catalog_table_alb_logs_arn" {
  value = aws_glue_catalog_table.alb_logs.arn
}
