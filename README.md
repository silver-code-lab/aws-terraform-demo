# AWS Web App Infrastructure with Terraform

This project provisions a complete AWS infrastructure using Terraform, designed to host and load balance a Docker-based web application on EC2.

## 🏗️ Infrastructure Overview

- **VPC** with CIDR `10.0.0.0/16`
- **2 Public Subnets** in separate Availability Zones (Mumbai region)
- **Internet Gateway** and **Route Table**
- **Security Groups**
  - For EC2: SSH (22), App port (3000)
  - For ALB: HTTP (80)
- **2 EC2 Instances** (`t3a.micro`) with:
  - Ubuntu AMI
  - Docker installed via `user_data`
  - Running the `adongy/hostname-docker` container
- **Application Load Balancer (ALB)** with:
  - Listener on port 80
  - Target Group forwarding traffic to instances on port 3000
- **Elastic IPs** automatically assigned (via `associate_public_ip_address`)
- **Scalable and reusable Terraform structure**

## 🚀 Setup Instructions

1. **Clone the repo**
   ```bash
   git clone https://github.com/silver-code-lab/aws-terraform-demo.git
   cd aws-terraform-demo
   ```

2. **Initialize Terraform**
   ```bash
   terraform init
   ```

3. **Preview changes**
   ```bash
   terraform plan
   ```

4. **Apply the infrastructure**
   ```bash
   terraform apply -auto-approve
   ```

5. **Access your application**
   - Open the Load Balancer DNS output in your browser (port 80).
   - Or use the EC2 Public IPs (port 3000).

6. **Destroy the infrastructure**
   ```bash
   terraform destroy -auto-approve
   ```

## 📁 File Structure

- `providers.tf` – AWS provider and region config
- `vpc.tf` – VPC, Subnets, IGW, Route Tables
- `instances.tf` – EC2 instances, Security Groups, user_data
- `alb.tf` – ALB, Target Group, Listener, Attachments
- `outputs.tf` – Public IPs and ALB DNS output

## 🔐 Notes

- Make sure to update `key_name` in `instances.tf` to match your AWS Key Pair.
- `.terraform/`, `.terraform.lock.hcl`, and `terraform.tfstate` should be excluded from Git via `.gitignore`.
- The project uses Terraform `~> 5.0` with provider version pinning for stability.

## 🙋‍♂️ Author

Artium Shevchenko  
📎 [LinkedIn Profile](https://www.linkedin.com/in/artium-shevchenko-80208a34b/)
