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

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: ${each.key}
    timezone: Asia/Seoul
    users:
      - default
      - name: celestrial
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${var.ssh_pubkey}
        sudo: ALL=(ALL) NOPASSWD:ALL
    package_update: true
    packages:
      - qemu-guest-agent
      - apt-transport-https 
      - ca-certificates 
      - containerd
      - curl
      - gnupg
    sysctl:
      net.ipv4.ip_forward: "1"
    runcmd:
      - systemctl enable --now qemu-guest-agent
      - echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.34/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
      - curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.34/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
      - apt update
      - apt install -y kubelet kubeadm kubectl
      - sysctl -w net.ipv4.ip_forward=1
      - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "control-plain-config-${each.key}.yaml"
  }
}