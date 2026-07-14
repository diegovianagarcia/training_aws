BIA_API_URL=https://d2zb3b2o8t4que.cloudfront.net
cd client && VITE_API_URL=$BIA_API_URL npm run build

echo '>> Fazendo deploy dos assets'
aws s3 sync build s3://bia-bean-cdn/ --exclude "index.html" --profile bia

echo '>> Fazendo deploy do index.html'
aws s3 sync build s3://bia-bean-cdn/ --exclude "*" --include "index.html" --profile bia