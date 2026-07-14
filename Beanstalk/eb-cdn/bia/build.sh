versao=$(git rev-parse HEAD | cut -c 1-7)
aws ecr get-login-password --region us-east-1 --profile bia | docker login --username AWS \
    --password-stdin 095893258509.dkr.ecr.us-east-1.amazonaws.com
docker compose -f docker-compose-build-eb.yml build bia
docker tag bia:latest 095893258509.dkr.ecr.us-east-1.amazonaws.com/bia:$versao
docker push 095893258509.dkr.ecr.us-east-1.amazonaws.com/bia:$versao
./gerar-compose.sh
