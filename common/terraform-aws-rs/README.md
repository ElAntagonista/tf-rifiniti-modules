## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| dynamodb\_rc | Dynamodb table read capacity | string | `"20"` | no |
| dynamodb\_table\_name | The name of the dynamo db table | string | n/a | yes |
| dynamodb\_table\_tags | Tags to be set on the dynamodb table | map | `<map>` | no |
| dynamodb\_wc | Dynamodb table write capacity | string | `"20"` | no |
| s3\_bucket\_name | The bucket name for the S3 | string | n/a | yes |
| s3\_tags | Tags to be set on the S3 bucket | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| s3\_bucket\_domain\_name |  |
| s3\_bucket\_regional\_domain\_name |  |

