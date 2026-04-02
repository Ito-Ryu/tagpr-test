project_id       = "dev-project-id"
vpc_network_name = "dev-vpc"

subnets = [
  {
    name          = "dev-subnet"
    ip_cidr_range = "10.0.1.0/24"
    region        = "asia-northeast1"
  }
]

zone          = "asia-northeast1-a"
instance_name = "dev-vm-instance"
machine_type  = "e2-micro"
disk_image    = "debian-cloud/debian-12"

disk_name     = "dev-data-disk"
disk_size_gb  = 20
snapshot_name = "dev-data-disk-snapshot"
