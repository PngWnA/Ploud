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
  ssh {
    username  = "root"
    agent     = true
  }
}

locals {
  nodes = {
    "Sun" = { role = "Controller", ip = "10.24.68.1/24", gw = "10.24.0.1", vm_id = 1000000}
    "Mercury" = { role = "Worker", ip = "10.24.68.2/24", gw = "10.24.0.1", vm_id = 1000001 }
    "Venus" = { role = "Worker", ip = "10.24.68.3/24", gw = "10.24.0.1", vm_id = 1000002 }
    #"Earth" = { role = "Worker", ip = "10.24.68.4/24", gw = "10.24.0.1", vm_id = 1000003 }
    #"Mars" = { role = "Worker", ip = "10.24.68.5/24", gw = "10.24.0.1", vm_id = 1000004 }
    #"Jupiter" = { role = "Worker", ip = "10.24.68.6/24", gw = "10.24.0.1", vm_id = 1000005 }
    #"Saturn" = { role = "Worker", ip = "10.24.68.7/24", gw = "10.24.0.1", vm_id = 1000006 }
    #"Uranus" = { role = "Worker", ip = "10.24.68.8/24", gw = "10.24.0.1", vm_id = 1000007 }
    #"Neptune" = { role = "Worker", ip = "10.24.68.9/24", gw = "10.24.0.1", vm_id = 1000008 }
    #"Pluto" = { role = "Worker", ip = "10.24.68.10/24", gw = "10.24.0.1", vm_id = 1000009 }
  }
}

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
    dedicated = 8192
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
        proxmox_virtual_environment_file.control_plain_config[each.key].id :
        proxmox_virtual_environment_file.worker_plain_config[each.key].id
      )

    ip_config {
      ipv4 {
        address = each.value.ip
        gateway = each.value.gw
      }
    }    
  }
}