project_id       = "example-project-id"

vpc_network_name = "app1-vpc-network"

subnets = [
  {
    name          = "app1-subnet-01"
    ip_cidr_range = "10.0.1.0/24"
    region        = "asia-northeast1"
  },
  {
    name          = "app1-subnet-02"
    ip_cidr_range = "10.0.2.0/24"
    region        = "asia-northeast2"
  }
]
