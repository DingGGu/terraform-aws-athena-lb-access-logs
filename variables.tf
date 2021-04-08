variable "s3_bucket_name" {
  type = string
}

variable "athena_database_s3_bucket_name" {
  type = string
}

variable "athena_database" {
  default = "lb_access_log"
  type = string
}

variable "partition_projection_range" {
  default = "NOW-6MONTHS,NOW"
  type = string
}

