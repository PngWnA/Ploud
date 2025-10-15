variable proxmox_api_endpoint {
    description = "The API endpoint of the Proxmox VE server"
    type = string
}
variable proxmox_api_token {
    description = "The API token secret of the Proxmox VE server"
    type = string
}
variable pm_node {
    description = "The node name of the Proxmox VE server"
    type = string
}
variable image_storage {
    description = "The storage name of the Proxmox VE server"
    type = string
}
variable template_id {
    description = "The template ID of the Proxmox VE server"
    type = string
}
variable data_storage {
    description = "The storage name of the Proxmox VE server"
    type = string
}
variable vm_storage {
    description = "The storage name of the Proxmox VE server"
    type = string
}
variable vm_network_bridge {
    description = "The network bridge of the Proxmox VE server"
    type = string
}
variable ssh_pubkey {
    description = "The SSH public key of the Proxmox VE server"
    type = string
}