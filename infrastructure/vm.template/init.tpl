users:
  - name: celestrial
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - ${ssh_pubkey}
package_update: true
package_upgrade: false
runcmd:
  - [ bash, -lc, "timedatectl set-timezone Asia/Seoul" ]