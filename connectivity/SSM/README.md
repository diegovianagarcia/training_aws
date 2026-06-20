## SSH connection in a public resource
```sh
ssh -i my_key.pem user@host
```

## SSH with bastion host
### in Linux
```sh
ssh -f -N -i formacao.pem -L 2222:172.32.138.177:22 ec2-user@ec2-54-210-117-124.compute-1.amazonaws.com
ssh -i formacao.pen ec2-user@localhost -p 2222 
```
### in Windows
```sh
ssh -f -N -i formacao.pem -L 3389:172.32.138.177:3389 ec2-user@ec2-54-210-117-124.compute-1.amazonaws.com
# Connect to rdp client
```
### in RDS - PostgreSQL
```sh
ssh -f -N -i formacao.pem -L 5435:bia.co70gok8o718.us-east-1.rds.amazonaws.com:5432 ec2-user@ec2-54-210-117-124.compute-1.amazonaws.com
# Connect to db client
```

## Instance connect via aws cli (automatically key generation and pushing)
```sh
aws ec2-instance-connect ssh --instance-id i-0123456789abcdef0
```

## Manual Public Key Push (For Standard SSH Clients)
### Send your public key to the instance:
```sh
aws ec2-instance-connect send-ssh-public-key \
    --instance-id i-0123456789abcdef0 \
    --instance-os-user ec2-user \
    --ssh-public-key file://~/.ssh/id_rsa.pub
```
### Connect immediately via SSH (within the 60-second window):
```sh
ssh -i ~/.ssh/id_rsa ec2-user@<INSTANCE_PUBLIC_IP>
```

## Endpoint Connection (For Private Subnet Instances)
```sh
aws ec2-instance-connect ssh --instance-id i-0123456789abcdef0 --connection-type eice
```


## SSM connection

### Simple session
```sh
aws ssm start-session --target i-1234567890abcdef0
```

### Port forwarding
```sh
aws ssm start-session --target i-1234567890abcdef0 \
  --document-name AWS-StartPortForwardingSession \
  --parameters '{"portNumber":["3306"],"localPortNumber":["3306"]}'
aws ssm start-session --target i-1234567890abcdef0
```

### Port forwarding to connecto to remote hosts in the private networks
```sh
aws ssm start-session --target i-1234567890abcdef0 \
  --document-name AWS-StartPortForwardingSessionToRemoteHost \
  --parameters '{"host":["mydb.cluster.us-east-1.rds.amazonaws.com"],"portNumber":["5432"],"localPortNumber":["5432"]}'
```

## SSH via SSM
```sh
aws ssm start-session --target i-1234567890abcdef0 \
  --document-name AWS-StartSSHSession \
  --parameters '{"portNumber":["22"]}'
aws ssm start-session --target i-1234567890abcdef0
```

## instance connect via instance connect EndPoint
### Linux
```sh
aws ec2-instance-connect ssh --instance-id i-0464a72568030d782 --profile bia
```

### Windows
```sh
aws ec2-instance-connect open-tunnel --instance-id i-0aed4693aadb7041e --remote-port 3389 --local-port 3389 --profile bia
```
