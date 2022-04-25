ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

echo "ACCOUNT_ID: $ACCOUNT_ID"
sleep 1

docker build -t cpu-api .

docker tag cpu-api:latest ${ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/cpu-api:latest

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com

docker push ${ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/cpu-api:latest