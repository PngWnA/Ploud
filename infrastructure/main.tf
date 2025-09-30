terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.80"
    }
  }
}

provider proxmox {
  endpoint  = var.proxmox_api_endpoint
  api_token = var.proxmox_api_token 
}

locals {
  nodes = {
    "Sun" = { role = "SolarSystem", ip = "10.24.68.1/24", gw = "10.24.0.1", vm_id = 1000000}
    "Mercury" = { role = "SolarSystem", ip = "10.24.68.2/24", gw = "10.24.0.1", vm_id = 1000001 }
    "Venus" = { role = "SolarSystem", ip = "10.24.68.3/24", gw = "10.24.0.1", vm_id = 1000002 }
    "Earth" = { role = "SolarSystem", ip = "10.24.68.4/24", gw = "10.24.0.1", vm_id = 1000003 }
  }
}

resource proxmox_virtual_environment_vm vm {
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
    ip_config {
      ipv4 {
        address = each.value.ip
        gateway = each.value.gw
      }
    }

    user_account {
      username = "ubuntu"
      keys     = [var.ssh_pubkey]
    }
  }
}