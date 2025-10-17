resource proxmox_virtual_environment_vm cluster {
  for_each  = local.nodes
  name      = each.key
  node_name = var.pm_node
  vm_id     = each.value.vm_id

  stop_on_destroy = true

  cpu {
    cores   = 4
    sockets = 1
  }

  memory {
    dedicated = 4096
  }

  disk {
    interface    = "scsi0"
    datastore_id = var.vm_storage
    import_from  = proxmox_virtual_environment_download_file.ubuntu.id
    size         = 32
  }

  network_device {
    model  = "virtio"
    bridge = var.vm_network_bridge
  }

  agent {
    enabled = true
  }

  initialization {
    user_data_file_id = (
      each.value.role == "Controller" ?
      proxmox_virtual_environment_file.controller_plane[each.key].id :
      proxmox_virtual_environment_file.worker_plane[each.key].id
    )

    ip_config {
      ipv4 {
        address = each.value.ip
        gateway = each.value.gw
      }
    }    
  }
}