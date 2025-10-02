resource proxmox_virtual_environment_download_file ubuntu {
  content_type = "import"
  datastore_id = var.image_storage
  node_name    = var.pm_node
  url          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  file_name    = "noble-server-cloudimg-amd64.qcow2"
}

resource proxmox_virtual_environment_file controller_plain {
  for_each     = toset(local.controller_plain)
  content_type = "snippets"
  datastore_id = var.data_storage
  node_name    = var.pm_node
  
  source_raw {
    data = templatefile("cloud_init/controller-plain.yaml", {
      hostname    = each.key
      ssh_pubkey  = var.ssh_pubkey
    })
    file_name = "controller-plain-${each.key}.yaml"
  }
}

resource proxmox_virtual_environment_file worker_plain {
  for_each     = toset(local.worker_plain)
  content_type = "snippets"
  datastore_id = var.data_storage
  node_name    = var.pm_node
  
  source_raw {
    data = templatefile("cloud_init/worker-plain.yaml", {
      hostname    = each.key
      ssh_pubkey  = var.ssh_pubkey
    })
    file_name = "worker-plain-${each.key}.yaml"
  }
}