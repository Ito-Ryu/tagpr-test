resource "google_compute_disk" "data_disk" {
  name    = var.disk_name
  type    = "pd-standard"
  zone    = var.zone
  project = var.project_id
  size    = var.disk_size_gb
}

resource "google_compute_snapshot" "disk_snapshot" {
  name        = var.snapshot_name
  project     = var.project_id
  source_disk = google_compute_disk.data_disk.id
  zone        = var.zone
}

resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }

  attached_disk {
    source      = google_compute_disk.data_disk.id
    device_name = google_compute_disk.data_disk.name
  }

  network_interface {
    subnetwork = var.subnetwork_id
    # 外部IPが必要な場合は以下の access_config ブロックを有効にします
    # access_config {}
  }
}
