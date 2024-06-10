resource "aws_glue_catalog_database" "lb_access_log" {
  name = var.athena_database
}

resource "aws_glue_catalog_table" "alb_logs" {
  name          = "alb_logs"
  owner         = "hadoop"
  database_name = aws_glue_catalog_database.lb_access_log.name

  table_type = "EXTERNAL_TABLE"

  parameters = {
    "has_encrypted_data"                = "false"
    "EXTERNAL"                          = "TRUE"
    "projection.enabled"                = "true"
    "projection.date_day.format"        = "yyyy/MM/dd"
    "projection.date_day.interval"      = "1"
    "projection.date_day.interval.unit" = "DAYS"
    "projection.date_day.range"         = var.partition_projection_range
    "projection.date_day.type"          = "date"
    "storage.location.template"         = "s3://${var.s3_bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/elasticloadbalancing/${data.aws_region.current.name}/$${date_day}"
  }

  retention = 0

  partition_keys {
    name = "date_day"
    type = "string"
  }

  storage_descriptor {
    bucket_columns            = []
    compressed                = false
    input_format              = "org.apache.hadoop.mapred.TextInputFormat"
    location                  = "s3://${var.s3_bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/elasticloadbalancing/${data.aws_region.current.name}"
    number_of_buckets         = -1
    output_format             = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    stored_as_sub_directories = false

    columns {
      name = "type"
      type = "string"
    }
    columns {
      name = "time"
      type = "string"
    }
    columns {
      name = "elb"
      type = "string"
    }
    columns {
      name = "client_ip"
      type = "string"
    }
    columns {
      name = "client_port"
      type = "int"
    }
    columns {
      name = "target_ip"
      type = "string"
    }
    columns {
      name = "target_port"
      type = "int"
    }
    columns {
      name = "request_processing_time"
      type = "double"
    }
    columns {
      name = "target_processing_time"
      type = "double"
    }
    columns {
      name = "response_processing_time"
      type = "double"
    }
    columns {
      name = "elb_status_code"
      type = "string"
    }
    columns {
      name = "target_status_code"
      type = "string"
    }
    columns {
      name = "received_bytes"
      type = "bigint"
    }
    columns {
      name = "sent_bytes"
      type = "bigint"
    }
    columns {
      name = "request_verb"
      type = "string"
    }
    columns {
      name = "request_url"
      type = "string"
    }
    columns {
      name = "request_proto"
      type = "string"
    }
    columns {
      name = "user_agent"
      type = "string"
    }
    columns {
      name = "ssl_cipher"
      type = "string"
    }
    columns {
      name = "ssl_protocol"
      type = "string"
    }
    columns {
      name = "target_group_arn"
      type = "string"
    }
    columns {
      name = "trace_id"
      type = "string"
    }
    columns {
      name = "domain_name"
      type = "string"
    }
    columns {
      name = "chosen_cert_arn"
      type = "string"
    }
    columns {
      name = "matched_rule_priority"
      type = "string"
    }
    columns {
      name = "request_creation_time"
      type = "string"
    }
    columns {
      name = "actions_executed"
      type = "string"
    }
    columns {
      name = "redirect_url"
      type = "string"
    }
    columns {
      name = "lambda_error_reason"
      type = "string"
    }
    columns {
      name = "target_port_list"
      type = "string"
    }
    columns {
      name = "target_status_code_list"
      type = "string"
    }
    columns {
      name = "classification"
      type = "string"
    }
    columns {
      name = "classification_reason"
      type = "string"
    }
    columns {
      name = "tid"
      type = "string"
    }

    ser_de_info {
      parameters = {
        "input.regex"          = "([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*):([0-9]*) ([^ ]*)[:-]([0-9]*) ([-.0-9]*) ([-.0-9]*) ([-.0-9]*) (|[-0-9]*) (-|[-0-9]*) ([-0-9]*) ([-0-9]*) \"([^ ]*) (.*) (- |[^ ]*)\" \"([^\"]*)\" ([A-Z0-9-_]+) ([A-Za-z0-9.-]*) ([^ ]*) \"([^\"]*)\" \"([^\"]*)\" \"([^\"]*)\" ([-.0-9]*) ([^ ]*) \"([^\"]*)\" \"([^\"]*)\" \"([^ ]*)\" \"([^\s]+?)\" \"([^\s]+)\" \"([^ ]*)\" \"([^ ]*)\" ?([^ ]*)?"
        "serialization.format" = "1"
      }
      serialization_library = "org.apache.hadoop.hive.serde2.RegexSerDe"
    }
  }
}

resource "aws_glue_catalog_table" "nlb_logs" {
  name          = "nlb_logs"
  owner         = "hadoop"
  database_name = aws_glue_catalog_database.lb_access_log.name

  table_type = "EXTERNAL_TABLE"

  parameters = {
    "has_encrypted_data"                = "false"
    "EXTERNAL"                          = "TRUE"
    "projection.enabled"                = "true"
    "projection.date_day.format"        = "yyyy/MM/dd"
    "projection.date_day.interval"      = "1"
    "projection.date_day.interval.unit" = "DAYS"
    "projection.date_day.range"         = var.partition_projection_range
    "projection.date_day.type"          = "date"
    "storage.location.template"         = "s3://${var.s3_bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/elasticloadbalancing/${data.aws_region.current.name}/$${date_day}"
  }

  retention = 0

  partition_keys {
    name = "date_day"
    type = "string"
  }

  storage_descriptor {
    bucket_columns            = []
    compressed                = false
    input_format              = "org.apache.hadoop.mapred.TextInputFormat"
    location                  = "s3://${var.s3_bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/elasticloadbalancing/${data.aws_region.current.name}"
    number_of_buckets         = -1
    output_format             = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    stored_as_sub_directories = false

    columns {
      name = "type"
      type = "string"
    }
    columns {
      name = "version"
      type = "string"
    }
    columns {
      name = "time"
      type = "string"
    }
    columns {
      name = "elb"
      type = "string"
    }
    columns {
      name = "listener_id"
      type = "string"
    }
    columns {
      name = "client_ip"
      type = "string"
    }
    columns {
      name = "client_port"
      type = "int"
    }
    columns {
      name = "target_ip"
      type = "string"
    }
    columns {
      name = "target_port"
      type = "int"
    }
    columns {
      name = "tcp_connection_time_ms"
      type = "double"
    }
    columns {
      name = "tls_handshake_time_ms"
      type = "double"
    }
    columns {
      name = "received_bytes"
      type = "bigint"
    }
    columns {
      name = "sent_bytes"
      type = "bigint"
    }
    columns {
      name = "incoming_tls_alert"
      type = "int"
    }
    columns {
      name = "cert_arn"
      type = "string"
    }
    columns {
      name = "certificate_serial"
      type = "string"
    }
    columns {
      name = "tls_cipher_suite"
      type = "string"
    }
    columns {
      name = "tls_protocol_version"
      type = "string"
    }
    columns {
      name = "tls_named_group"
      type = "string"
    }
    columns {
      name = "domain_name"
      type = "string"
    }
    columns {
      name = "alpn_fe_protocol"
      type = "string"
    }
    columns {
      name = "alpn_be_protocol"
      type = "string"
    }
    columns {
      name = "alpn_client_preference_list"
      type = "string"
    }
    columns {
      name = "tls_connection_creation_time"
      type = "string"
    }

    ser_de_info {
      parameters = {
        "input.regex"          = "([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*):([0-9]*) ([^ ]*):([0-9]*) ([-.0-9]*) ([-.0-9]*) ([-0-9]*) ([-0-9]*) ([-0-9]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*)$"
        "serialization.format" = "1"
      }
      serialization_library = "org.apache.hadoop.hive.serde2.RegexSerDe"
    }
  }
}
