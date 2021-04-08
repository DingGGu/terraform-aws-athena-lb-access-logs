# terraform-aws-athena-lb-access-logs
A terraform module to create ALB Glue Catalog for Athena.

## Features
1. Glue Catalog support Athena Partition Projection. So you don't have to manage partition keys.
2. Partition benefits reduce your data scanning cost and improve scanning speed.

## Usage example
```hcl
data "aws_region" "current" {
}

module "lb_logs" {
  source = "github.com/DingGGu/terraform-aws-athena-lb-access-logs.git"
  athena_database_s3_bucket_name = "aws-athena-query-results-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
  s3_bucket_name = "<LB_ACCESS_LOG_BUCKET_NAME>"
}
```

Execute query on Athena.
```sql
SELECT * FROM "lb_access_log"."alb_logs" WHERE date_day = '2021/04/06' limit 10;
```

## Reference
