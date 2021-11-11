mkdir -p ../logs
cd docker
docker compose up -d
docker exec -it dl /bin/bash
jupyter list