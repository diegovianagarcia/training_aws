INSTANCE_ID=i-0fe3c46ecf364eb40

aws ec2-instance-connect send-ssh-public-key \
    --instance-id $INSTANCE_ID \
    --instance-os-user ec2-user \
    --ssh-public-key file://~/my_key.pub \
    --profile bia

ssh -o "IdentitiesOnly=yes" -i ~/my_key ec2-user@localhost -p 2221