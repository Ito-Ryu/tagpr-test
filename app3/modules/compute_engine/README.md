# Compute Engine Module (app3)

VMインスタンスとデータディスク、およびそのスナップショットを一括作成する。

## Usage

```hcl
module "compute_engine" {
  source = "github.com/Ito-Ryu/tagpr-test//app3/modules/compute_engine?ref=v0.0.1"

  project_id    = "your-project-id"
  zone          = "asia-northeast1-a"
  subnetwork_id = "projects/your-project-id/regions/asia-northeast1/subnetworks/subnet-a"
  
  instance_name = "my-vm-instance"
  machine_type  = "e2-medium"
  
  disk_name     = "my-data-disk"
  disk_size_gb  = 50
  snapshot_name = "my-data-disk-snapshot"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_id | The ID of the Google Cloud project. | `string` | n/a | yes |
| zone | The zone to deploy resources into. | `string` | n/a | yes |
| subnetwork_id | The ID or self_link of the subnetwork to attach the VM to. | `string` | n/a | yes |
| instance_name | The name of the Compute Engine instance. | `string` | n/a | yes |
| disk_image | The image from which to initialize the boot disk. | `string` | `"debian-cloud/debian-12"` | no |
| machine_type | The machine type of the Compute Engine instance. | `string` | `"e2-micro"` | no |
| disk_name | The name of the external disk. | `string` | n/a | yes |
| disk_size_gb | The size of the disk in GB. | `number` | `10` | no |
| snapshot_name | The name of the snapshot for the disk. | `string` | n/a | yes |

## Minor label