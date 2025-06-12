# Minecraft Server Part 2

## Requirements

- AWS CLI
- Terraform
- Ansible
- Git
  
### 1. Clone Repo
  git clone https://github.com/mannydoorman/Minecraft-server
  
  cd minecraft-server

### 2. Configure 

Ensure your AWS credentials and region are set:

  export AWS_ACCESS_KEY_ID=(insert) 
  export AWS_SECRET_ACCESS_KEY=(insert) 
  export AWS_REGION=(ex. us-east-1)
  export AWS_SESSION_TOKEN=(insert) 

or..

  notepad %USERPROFILE%\.aws\credentials

..and edit the lines there

### 3. Terraform

Navigate to the Terraform directory, initialize, plan, and apply:

  cd terraform
  terraform init
  terraform plan
  terraform apply


On success, Terraform will output the EC2 public IP and other critical info.

Note down the public ip.

### 4. Ansible 

Update inventory/hosts.ini with the public IP from Terraform:

  [minecraft]
  <ec2_public_ip> ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/<key>.pem

Run the playbook:
  cd ../ansible
  ansible-playbook -i inventory/hosts.ini playbook.yml


This installs Docker, deploys the Minecraft container, and configures the systemd service for auto‑restart.

### 5. Verification
Connects to ec2_public_ip:25565

Check
  nmap -sV -Pn -p 25565 $EC2_PUBLIC_IP

Service status
  ssh -i ~/.ssh/<key>.pem ubuntu@$EC2_PUBLIC_IP \
    sudo systemctl status minecraft-docker

### 6. Cleanup

To destroy all resources and avoid charges:
  cd terraform
  terraform destroy -auto-approve

