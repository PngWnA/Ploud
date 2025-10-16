# Internal DHCP
* 특정 bridge interface가 DHCP 할당을 할 수 있도록 설정합니다.

# Prerequisite
* `dnsmasq` 설치
```bash
apt install dnsmasq -y

```

# Install
* `vmbr1.conf` 파일을 `/etc/dnsmasq.d` 아래 위치시킨다
* `interfaces` 파일의 내용을 `/etc/network/interfaces`에 추가한다
