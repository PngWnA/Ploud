resource proxmox_virtual_environment_download_file ubuntu {
  content_type = "import"
  datastore_id = var.image_storage
  node_name    = var.pm_node
  url          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  file_name    = "noble-server-cloudimg-amd64.qcow2"
}

resource proxmox_virtual_environment_file cloud_init_config {
  for_each     = local.nodes
  content_type = "snippets"
  datastore_id = var.data_storage
  node_name    = var.pm_node
  
  source_raw {
    data = templatefile("cloud_init/cloud-init-config.yaml", {
      hostname    = each.key
      ssh_pubkey  = var.ssh_pubkey
    })
    file_name = "cloud-init-config-${each.key}.yaml"
  }
}