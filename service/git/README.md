# Git server

# Note
* 권한 문제로 인하여 rootless docker에서 동작
* `postgres` 설정 오류로 인해 컨테이너 시작 후 직접 데이터베이스를 생성해줘야함
```bash
psql -h 127.0.0.1 -U gitea -d postgres -c 'CREATE DATABASE gitea';
```
* user git의 UID, GID를 `docker-compose.yml`에 반영해야함