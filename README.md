🚀 Self-Healing Java Microservice on AWS

Cloud-deployed Spring Boot microservice demonstrating layered self-healing, auto-scaling infrastructure, and automated CI/CD with integrated security scanning.

🧠 Project Overview

This project showcases how modern cloud-native systems achieve resilience using multiple recovery layers:

Application health monitoring

Container-level restart mechanisms

Instance-level auto-replacement

Load balancer traffic isolation

CPU-based horizontal scaling

Infrastructure is provisioned using Terraform and deployments are automated via GitHub Actions.

🏗️ Architecture
Developer Push → GitHub
        ↓
GitHub Actions CI Pipeline
   ├─ Build (Maven)
   ├─ Security Scan (Snyk)
   ├─ Docker Build
   └─ Push to Docker Hub
        ↓
Docker Hub
        ↓
AWS Infrastructure (Terraform)
   ├─ VPC (Multi-AZ)
   ├─ Application Load Balancer
   ├─ Target Group (Health Checks)
   ├─ Auto Scaling Group (2–4 instances)
   └─ EC2 Instances (Docker runtime)
        ↓
Spring Boot Container

✨ Key Features

Multi-layer self-healing architecture

Auto Scaling Group (2–4 instances, CPU-based scaling)

ALB health checks (30s interval)

Dockerized Spring Boot application

GitHub Actions CI/CD pipeline

Snyk vulnerability scanning (Maven + Docker image)

Infrastructure as Code using Terraform

Multi-AZ deployment for high availability

🛠 Tech Stack
Application

Java 17

Spring Boot 3.x

Spring Boot Actuator

Maven

DevOps

Docker

GitHub Actions

Snyk (dependency & image scanning)

Docker Hub

Cloud

AWS EC2

AWS Auto Scaling Group

AWS Application Load Balancer

AWS CloudWatch

AWS VPC

Terraform

🔄 Self-Healing Strategy

This system implements layered recovery mechanisms.

1️⃣ Application-Level Monitoring

/actuator/health endpoint

Liveness and readiness states

Health status exposed to Docker and ALB

2️⃣ Container-Level Recovery

Docker health checks configured

Container marked unhealthy after repeated failures

Automatic restart via Docker runtime

3️⃣ Instance-Level Recovery

Auto Scaling Group monitors instance health

Unhealthy instances are terminated and replaced

Desired capacity maintained automatically

4️⃣ Traffic-Level Isolation

ALB performs health checks every 30 seconds

Unhealthy instances removed from rotation

Traffic routed only to healthy targets

5️⃣ Demand-Based Scaling

CloudWatch CPU alarm (80% target)

ASG adds instances under sustained load

Scales down during low traffic

🔄 CI/CD Pipeline

Triggered on push to main.

Pipeline Steps

Checkout code

Build with Maven

Run Snyk dependency scan

Build Docker image

Push image to Docker Hub

Run Snyk Docker image scan

Pipeline fails automatically on high-severity vulnerabilities.

GitHub Actions Status

🐳 Local Development
Build
./mvnw clean package

Run locally
./mvnw spring-boot:run

Test health endpoint
curl http://localhost:8080/actuator/health

🐳 Docker Usage
Build image
docker build -t selfhealing-app .

Run container
docker run -d -p 8080:8080 --name selfhealing selfhealing-app

Verify health
docker ps


Container status will show (healthy) after health checks succeed.

☁️ AWS Deployment (Terraform)
Provision Infrastructure
cd terraform
terraform init
terraform plan
terraform apply

Retrieve Load Balancer URL
terraform output alb_dns_name

Test Deployment
curl http://<alb-dns-name>/actuator/health

Cleanup (Important)
terraform destroy


Always destroy infrastructure when not in use to avoid AWS charges.

📊 Monitoring Configuration
ALB Health Check

Path: /actuator/health

Interval: 30 seconds

Timeout: 5 seconds

Healthy threshold: 2

Unhealthy threshold: 3

Auto Scaling

Metric: Average CPU Utilization

Target: 80%

Min instances: 2

Max instances: 4

Desired: 2

📁 Project Structure
java-self-healing-microservice/
├── .github/workflows/ci.yml
├── src/
│   ├── main/java/com/sriram/selfhealing/
│   ├── main/resources/
│   └── test/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
├── Dockerfile
├── pom.xml
├── mvnw
└── README.md

🔐 Security Considerations

No hardcoded AWS credentials

IAM roles used for EC2 instances

Snyk vulnerability scanning integrated into CI

Security groups restrict inbound traffic

Sensitive files excluded via .gitignore

🎓 What This Project Demonstrates

Designing resilient distributed systems

Implementing layered self-healing strategies

Automating build and security validation

Managing infrastructure using Terraform

Operating containerized workloads on AWS

Understanding load balancer health logic

CPU-based horizontal scaling strategies

📌 Future Improvements

Blue/Green deployment strategy

Private subnets with NAT

HTTPS termination with ACM

Centralized logging (ELK / CloudWatch Logs)

Prometheus + Grafana monitoring

ECR instead of Docker Hub

OIDC-based GitHub → AWS authentication

👤 Author

Sannidhi Sriram

GitHub: https://github.com/SannidhiSriram-06

Docker Hub: https://hub.docker.com/r/sannidhisriram/selfhealing-app
