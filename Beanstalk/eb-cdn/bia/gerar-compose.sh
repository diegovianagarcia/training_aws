versao=$(git rev-parse HEAD | cut -c 1-7)
echo TAG=$versao > .env
docker compose -f docker-compose-eb.yml config --no-normalize > docker-compose.yml
