resource proxmox_virtual_environment_download_file ubuntu {
  content_type = "import"
  datastore_id = var.image_storage
  node_name    = var.pm_node
  url          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  file_name    = "noble-server-cloudimg-amd64.qcow2"
}

resource proxmox_virtual_environment_file controller_plane {
  for_each     = toset(local.controller_plane)
  content_type = "snippets"
  datastore_id = var.data_storage
  node_name    = var.pm_node
  
  source_raw {
    data = templatefile("cloud-init/controller-plane.yaml", {
      hostname    = each.key
      ssh_pubkey  = var.ssh_pubkey
    })
    file_name = "controller-plane-${each.key}.yaml"
  }
}

resource proxmox_virtual_environment_file worker_plane {
  for_each     = toset(local.worker_plane)
  content_type = "snippets"
  datastore_id = var.data_storage
  node_name    = var.pm_node
  
  source_raw {
    data = templatefile("cloud-init/worker-plane.yaml", {
      hostname    = each.key
      ssh_pubkey  = var.ssh_pubkey
    })
    file_name = "worker-plane-${each.key}.yaml"
  }
}