# VPC Module (app2)

VPCネットワーク単体を作成するモジュール。

## Usage

```hcl
module "vpc" {
  source = "github.com/Ito-Ryu/tagpr-test//app2/vpc?ref=v0.0.1"

  project_id       = "your-project-id"
  vpc_network_name = "my-custom-vpc"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_id | The ID of the Google Cloud project. | `string` | n/a | yes |
| vpc_network_name | The name of the VPC network. | `string` | n/a | yes |