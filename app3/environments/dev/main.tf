module "network" {
  source = "../../modules/network"

  project_id       = var.project_id
  vpc_network_name = var.vpc_network_name
  subnets          = var.subnets
}

module "compute_engine" {
  source = "../../modules/compute_engine"

  project_id    = var.project_id
  zone          = var.zone
  
  subnetwork_id = module.network.subnets["dev-subnet"].id
  
  instance_name = var.instance_name
  machine_type  = var.machine_type
  disk_image    = var.disk_image
  
  disk_name     = var.disk_name
  disk_size_gb  = var.disk_size_gb
  snapshot_name = var.snapshot_name
}
