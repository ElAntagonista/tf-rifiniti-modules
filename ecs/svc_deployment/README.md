## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alb\_http\_listener\_arn | The id of the Load balancer | string | n/a | yes |
| alb\_security\_group | The id of the ALB security group | string | n/a | yes |
| app\_image | Image name for the task. Should correspond to a ECR repository | string | n/a | yes |
| app\_image\_tag | Image tag | string | `"latest"` | no |
| app\_name | Name of the ECS service to be deployed | string | n/a | yes |
| app\_port | The port that the app would be listening on | string | n/a | yes |
| ecr\_url | The base url of the ECR registry | string | n/a | yes |
| ecs\_cluster\_id | The id of the ECS cluster | string | n/a | yes |
| fargate\_specs | Container cpu and memory specs for the task and container definitions | map | `<map>` | no |
| lb\_rule\_conditions\_field | Condition field for the lb_rule | string | `"path-pattern"` | no |
| lb\_rule\_conditions\_values | Condition values for the lb_rule | list | `<list>` | no |
| private\_subnet\_ids | Ids of the | string | n/a | yes |
| task\_count |  | string | `"1"` | no |
| task\_execution\_role\_arn | The execution role that should be used by the task. | string | n/a | yes |
| vpc\_id | Id of the the vpc | string | n/a | yes |

