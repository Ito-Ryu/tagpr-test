# Network Module (app3)

VPCネットワークとサブネットの一括作成を行う。

## Usage

```hcl
module "network" {
  source = "github.com/Ito-Ryu/tagpr-test//app3/modules/network?ref=v0.0.1"

  project_id       = "your-project-id"
  vpc_network_name = "my-custom-vpc"
  subnets = [
    {
      name          = "subnet-a"
      ip_cidr_range = "10.0.1.0/24"
      region        = "asia-northeast1"
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_id | The ID of the Google Cloud project. | `string` | n/a | yes |
| vpc_network_name | The name of the VPC network. | `string` | n/a | yes |
| subnets | The list of subnets to be created. | `list(object)` | `[]` | no |

