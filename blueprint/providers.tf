terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.80"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
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