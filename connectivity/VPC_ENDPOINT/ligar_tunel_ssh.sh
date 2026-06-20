aws ssm start-session --target i-0b733ba5c4e23eec0 \
  --document-name AWS-StartPortForwardingSessionToRemoteHost \
  --parameters '{"host":["ip-172-32-17-7.ec2.internal"],"portNumber":["22"],"localPortNumber":["8222"]}'