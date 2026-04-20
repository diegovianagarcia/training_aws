# Preparing the environment

## Requirement
- AWS SAM CLI
- AWS CLI
- Docker


# Install SAM Cli
```bash
curl -L "https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip" -o "aws-sam-cli-linux-x86_64.zip"
# Ensure unzip is installed
sudo apt update && sudo apt install unzip -y

# Unzip to a temporary directory
unzip aws-sam-cli-linux-*.zip -d sam-installation

# Run the installer
sudo ./sam-installation/install
# Verify
sam --version
```

# Using SAM

## Download the function code and AWS SAM file
Function `<file>.js` and `template.sam`

## Or create a function from scratch with scaffold
```bash
sam init
```
## Build the function
```bash
sam build
```
## Validating the template.yml
```bash
sam validate
```

## Invoke my local lambda function
```bash
sam local invoke exemplo-node --event events/event.json
```
## Deploy the function to AWS
Guided for create samconfig.toml
```bash
sam deploy --guided --profile <profile-name>
```
Delete all from AWS
```bash
sam delete --profile <profile-name>
```
