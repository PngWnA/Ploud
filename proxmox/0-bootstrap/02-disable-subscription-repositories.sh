sed -i.orig "s/.data.status.toLowerCase() !== 'active'/.data.status.toLowerCase() === '__DISABLED__'/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
systemctl restart pveproxy.service