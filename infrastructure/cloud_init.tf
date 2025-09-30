resource proxmox_virtual_environment_download_file ubuntu {
  content_type = "import"
  datastore_id = var.image_storage
  node_name    = var.pm_node
  url          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  file_name    = "noble-server-cloudimg-amd64.qcow2"
}