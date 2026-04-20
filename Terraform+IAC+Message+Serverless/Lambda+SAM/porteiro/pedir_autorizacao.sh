INSTANCE_ID_PORTEIRO=i-0befd180080e6a9d7
IP_PORTEIRO=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID_PORTEIRO --query "Reservations[].Instances[].PublicIpAddress" --profile bia-serverless --region us-east-1 --output json | grep -vE '\[|\]' | awk -F'"' '{ print $2 }')
echo $IP_PORTEIRO

PEM_PATH="/home/diego/Downloads/porteiro.pem"
SERVIDOR_RDS_1=bia.co70gok8o718.us-east-1.rds.amazonaws.com
PORTA_LOCAL_RDS_1=5435

ssh -f -N -i $PEM_PATH ec2-user@$IP_PORTEIRO -L $PORTA_LOCAL_RDS_1:$SERVIDOR_RDS_1:5432

echo "Porteiro liberou acesso para:"
echo "> $SERVIDOR_RDS_1 no endereço *127.0.0.1:$PORTA_LOCAL_RDS_1"