# Subnets Module (app2)

既存のVPCネットワーク内にサブネットのみを一括作成するモジュール。

## Usage

```hcl
module "subnets" {
  source = "github.com/Ito-Ryu/tagpr-test//app2/subnets?ref=v0.0.1"

  project_id = "your-project-id"
  network_id = "projects/your-project-id/global/networks/my-custom-vpc"
  
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
| network_id | The ID or self_link of the VPC network. | `string` | n/a | yes |
| subnets | The list of subnets to be created. | `list(object)` | `[]` | no |
