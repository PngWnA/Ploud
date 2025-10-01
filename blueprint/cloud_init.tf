resource proxmox_virtual_environment_download_file ubuntu {
  content_type = "import"
  datastore_id = var.image_storage
  node_name    = var.pm_node
  url          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  file_name    = "noble-server-cloudimg-amd64.qcow2"
}

resource proxmox_virtual_environment_file control_plain_config {
  for_each     = local.nodes
  content_type = "snippets"
  datastore_id = var.data_storage
  node_name    = var.pm_node
  
  source_file {
    path = "cloud_init/control-plain-config.yaml"
    file_name = "control-plain-config-${each.key}.yaml"
  }
}

resource proxmox_virtual_environment_file worker_plain_config {
  for_each     = local.nodes
  content_type = "snippets"
  datastore_id = var.data_storage
  node_name    = var.pm_node
  
  source_file {
    path = "cloud_init/worker-plain-config.yaml"
    file_name = "worker-plain-config-${each.key}.yaml"
  }
}