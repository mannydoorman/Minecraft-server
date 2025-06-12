Minecraft Server Part 2

## Requirements

- **AWS CLI** (v2.x) configured with appropriate credentials and default region.
- **Terraform** (>= 1.0.0) for infrastructure provisioning.
- **Ansible** (>= 2.9) for instance configuration.
- **Git** for version control.
- Environment variables:
  ```bash
  export AWS_PROFILE=your-profile      # as configured in ~/.aws/credentials
  export AWS_REGION=us-east-1          # or your preferred region
  ```
  
### 1. Clone the Repo

```bash
git clone https://github.com/<your-org>/minecraft-automation.git
cd minecraft-automation
```

### 2. Configure Environment

Ensure your AWS credentials and region are set:

```bash
export AWS_PROFILE=your-profile
export AWS_REGION=us-east-1
```

### 3. Terraform Workflow

Navigate to the Terraform directory, initialize, plan, and apply:

```bash
cd terraform
terraform init                                   # download providers
terraform plan -out=plan.tfplan                  # review changes
terraform apply plan.tfplan                      # provision resources
```

On success, Terraform will output the EC2 public IP and other critical info.

### 4. Ansible Configuration

1. Install dependencies locally:
   ```bash
   pip install ansible boto3
   ```
2. Update `inventory/hosts.ini` with the EC2 public IP from Terraform:
   ```ini
   [minecraft]
   <ec2_public_ip> ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/<key>.pem
   ```
3. Run the playbook:
   ```bash
   cd ../ansible
   ansible-playbook -i inventory/hosts.ini playbook.yml
   ```

This installs Docker, deploys the Minecraft container, and configures the systemd service for auto‑restart.

### 5. Verification

- **Minecraft client**: connect to `ec2_public_ip:25565`
- **Port scan**:
  ```bash
  nmap -sV -Pn -p 25565 $EC2_PUBLIC_IP
  ```
- **Service status**:
  ```bash
  ssh -i ~/.ssh/<key>.pem ubuntu@$EC2_PUBLIC_IP \
    "sudo systemctl status minecraft-docker"
  ```

### 6. Cleanup

To destroy all resources and avoid charges:

```bash
cd terraform
terraform destroy -auto-approve
```

---

*This README is written in GitHub Flavored Markdown. No manual steps involving the AWS Console or direct SSH are required beyond the initial key setup.*

