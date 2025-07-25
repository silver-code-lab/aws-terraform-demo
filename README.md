# AWS Web App Infrastructure with Terraform

This project provisions a complete AWS infrastructure using Terraform, designed to host a Docker-based web application.

## 🏗️ Infrastructure Overview

- **VPC** with CIDR `10.0.0.0/16`
- **2 Public Subnets** in separate Availability Zones (Mumbai region)
- **Internet Gateway** and **Route Table**
- **2 EC2 Instances** (type `t3a.micro`) with:
  - Docker installed
  - Running the `hostname-docker` container
- **Security Group** allowing:
  - SSH (port 22)
  - Web app (port 3000)
- **Elastic IPs** automatically assigned
- **Optional:** Application Load Balancer (ALB)

## 🚀 Setup Instructions

1. Clone the repo  
   ```bash
   git clone https://github.com/silver-code-lab/aws-terraform-demo.git
   cd aws-terraform-demo
   ```

2. Initialize Terraform  
   ```bash
   terraform init
   ```

3. Preview changes  
   ```bash
   terraform plan
   ```

4. Apply the infrastructure  
   ```bash
   terraform apply -auto-approve
   ```

5. Access your app  
   Open the public IPs output in your browser on port `3000`.

6. Destroy the infrastructure  
   ```bash
   terraform destroy -auto-approve
   ```

## 📁 File Structure

- `providers.tf` – AWS provider and region config
- `vpc.tf` – VPC, Subnets, IGW, Route Tables
- `instances.tf` – EC2 instances, Security Group, user_data
- `outputs.tf` – Public IP outputs

## 🔐 Notes

- Replace `key_name` in `instances.tf` with your valid AWS key pair name.
- Ensure `terraform.tfstate` is excluded from GitHub to avoid sensitive data exposure.

## 🙋‍♂️ Author

Artium Shevchenko  
📎 [LinkedIn Profile](https://www.linkedin.com/in/artium-shevchenko-80208a34b/)
