Java Self-Healing Microservice (AWS + CI/CD + DevSecOps)

Architecture

EC2 (Auto Scaling Group)

Application Load Balancer

Docker

GitHub Actions

Snyk

Docker Hub

Flow

Developer pushes to main

GitHub Actions:

Builds app

Runs tests

Scans with Snyk

Builds Docker image

Pushes to Docker Hub

EC2 pulls latest image

Container restarts

ALB serves traffic

Screenshots

GitHub Actions success

Snyk results

Docker Hub repo

AWS ASG

ALB target group healthy

/actuator/health
