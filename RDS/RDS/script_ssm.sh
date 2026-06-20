ID_PORTEIRO="i-0d66cf538b17e85ac"
#RDS_HOST="bia-serverless.cluster-co70gok8o718.us-east-1.rds.amazonaws.com"
RDS_HOST="bia-serverless-restore-cluster.cluster-co70gok8o718.us-east-1.rds.amazonaws.com"
# break line for better readability
aws ssm start-session --target $ID_PORTEIRO \
  --document-name AWS-StartPortForwardingSessionToRemoteHost \
  --parameters '{"host":["'$RDS_HOST'"],"portNumber":["5432"],"localPortNumber":["5434"]}' --region us-east-1