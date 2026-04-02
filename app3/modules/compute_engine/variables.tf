variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project."
}

variable "zone" {
  type        = string
  description = "The zone to deploy resources into."
}

variable "subnetwork_id" {
  type        = string
  description = "The ID or self_link of the subnetwork to attach the VM to."
}

variable "instance_name" {
  type        = string
  description = "The name of the Compute Engine instance."
}

variable "disk_image" {
  type        = string
  description = "The image from which to initialize the boot disk."
  default     = "debian-cloud/debian-12"
}

variable "machine_type" {
  type        = string
  description = "The machine type of the Compute Engine instance."
  default     = "e2-micro"
}

variable "disk_name" {
  type        = string
  description = "The name of the external disk."
}

variable "disk_size_gb" {
  type        = number
  description = "The size of the disk in GB."
  default     = 10
}

variable "snapshot_name" {
  type        = string
  description = "The name of the snapshot for the disk."
}
