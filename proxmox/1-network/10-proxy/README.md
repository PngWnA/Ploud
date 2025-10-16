# Prerequisite
* PVE Admin UI에서 인증서를 발급받아야 함

# Usage
`root` 권한으로 아래와 같이 실행
```bash
docker compose up -d
```

# Notes
* HTTP -> HTTPS redirection을 nginx에서 적용할 경우 DNS Provider의 설정과 충돌하여 무한 redirection에 걸릴 수 있음을 참고한다.
* 설정상에 SSL 인증서가 정의되었지만, repo에 존재하지 않는 경우 아래 예시와 같이 `certbot`등을 이용하여 다시 발급받는다.
```bash
sudo apt install certbot
sudo apt install python3-certbot-nginx

sudo certbot certonly --nginx --cert-name vpn.pngwna.net -d vpn.pngwna.net
sudo apt remove python3-certbot-nginx nginx
```