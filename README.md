\# README.md

\## Background

This project fully automates the provisioning and configuration of an
AWS-hosted Minecraft server using Terraform and Ansible. It mirrors our
manual setup (Part 1) by using Docker to run the official
\`itzg/minecraft-server\` image on an EC2 instance. Terraform handles
AWS resource creation (VPC, security group, EC2 instance, SSH key), and
Ansible installs and configures Docker, pulls the Minecraft container,
and ensures it auto-starts on boot.

\## Requirements

\- AWS CLI configured (\`aws configure\`) - Terraform \>= 1.4 -
Ansible \>= 2.9 - A local SSH keypair (public key for AWS Key Pair) -
Environment variables: \`\`\`bash export AWS_REGION=us-east-1 export
TF_VAR_ssh_key_name=my-key export
TF_VAR_ssh_public_key_path=\~/.ssh/id_rsa.pub \`\`\`

\## Architecture Diagram

\`\`\`mermaid graph LR A\[Terraform\] \--\> B\[VPC & Security Group\] B
\--\> C\[EC2 Instance\] C \--\> D\[Ansible\] D \--\> E\[Docker &
Minecraft Container\] \`\`\`

\## Directory Structure

\`\`\` ├── README.md ├── terraform/ │ ├── main.tf │ └── variables.tf └──
ansible/ ├── inventory.ini └── playbook.yml \`\`\`

\## Usage Steps

\### 0. Repository Setup

First, create a new GitHub repository (e.g., \`minecraft-automation\`)
and clone it locally: \`\`\`bash git clone
git@github.com:\<your-username\>/minecraft-automation.git cd
minecraft-automation \`\`\`

Then add the \`terraform/\` and \`ansible/\` directories (or copy this
repo structure) and your \`README.md\` file into the cloned folder. To
track them with Git:

\`\`\`bash \# Stage all new files for commit git add terraform ansible
README.md

\# Commit with a descriptive message git commit -m \"Initial commit: add
Terraform and Ansible configurations\"

\# Push to GitHub (assuming your default branch is \'main\') git push
origin main \`\`\`

Now your files are versioned in the remote repository.
