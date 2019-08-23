## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alb\_name | The name of the ALB | string | n/a | yes |
| alb\_security\_groups | Optional security groups to be provided | list | `<list>` | no |
| ecr\_repo\_names | The names of the ECR repos to be created | list | n/a | yes |
| ecs\_cluster\_name | The name of the ECS cluster | string | n/a | yes |
| iam\_role\_name | Name of the task execution IAM role | string | `"rifiniti-ecs"` | no |
| public\_subnet\_ids | The subnet ids that the ALB should use | list | n/a | yes |
| vpc\_id | The id of the VPC | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| alb\_domain\_name | The alb domain name |
| alb\_listener\_arn | The arn of the alb listener |
| alb\_sg\_id | The service group id of the alb |
| ecr\_base\_url | The base url for the ECR |
| ecs\_cluster\_id | The id of the ECS cluster |
| task\_execution\_role\_arn | The execution role used by the ECS task |

