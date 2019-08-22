## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| az\_count | Number of Availability zones | string | `"2"` | no |
| create\_ecr\_vpc\_endpoint | Boolean flag to enable the creation of ECR vpc endpoints | string | `"true"` | no |
| enable\_vpc\_dns | Boolean flag to enable dns in VPC | string | `"true"` | no |
| enable\_vpc\_dns\_hostname | Boolean flag to enable hostnames in vpc | string | `"true"` | no |
| vpc\_cidr\_block | CIDR block for the vpc | string | `"172.17.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| ecr\_vpc\_ept\_id | ECR id |
| ecr\_vpc\_ept\_sg\_ids | ECR vpc endpoint Security group id(s) |
| private\_subnet\_cidr\_blocks | Private subnet(s) cidr block(s) |
| private\_subnet\_ids | Private subnet(s) id |
| public\_subnet\_cidr\_blocks | Public subnet(s) cidr block(s) |
| public\_subnet\_ids | Public subnet(s) id |
| vpc\_arn | The ARN of the VPC |
| vpc\_id | The id of the vpc |
| vpc\_main\_route\_table\_id | Vpc's main route table |

