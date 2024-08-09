# CI/CD Pipeline for Dockerized Application Deployment

This project sets up a complete CI/CD pipeline to automate the deployment of a Dockerized web application. It integrates multiple tools to streamline the development, testing, and deployment processes, ensuring high code quality, security, and efficient artifact management.

## Tools Used

- **Git**: Source code management.
- **Jenkins**: Orchestration of the CI/CD pipeline.
- **SonarQube**: Code quality analysis.
- **Trivy**: Vulnerability scanning for Docker images.
- **Docker**: Containerization of the application.
- **AWS EC2**: Hosting environment for Jenkins, SonarQube, and the application.

## Overview

The pipeline encompasses the following stages:

1. **Code Retrieval**: Fetches the latest code from a GitHub repository.
2. **Code Quality Analysis**: Analyzes the code for quality and security issues using SonarQube.
3. **Security Scanning**: Scans the application and Docker image for vulnerabilities using Trivy and OWASP Dependency-Check.
4. **Docker Image Build**: Packages the application into a Docker image.
5. **Artifact Management**: Tags and pushes the Docker image to DockerHub.
6. **Deployment**: Deploys the Dockerized application on an AWS EC2 instance.

### Key Steps

1. **Setup**: Launch an EC2 instance with Jenkins, Docker, SonarQube, and Trivy installed.
2. **Configure Jenkins**: Install necessary plugins and create a pipeline job to automate the CI/CD process.
3. **Pipeline Execution**: Automate the entire process from code retrieval to deployment.
4. **Monitoring**: Review build, quality, and deployment statuses to ensure smooth operation.

## Outputs

Screenshots and logs of the following components will provide insights into the successful execution of the pipeline:

- **Jenkins**: Build and deployment status.
- **SonarQube**: Code quality reports.
- **Trivy**: Security scan results.
- **DockerHub**: Pushed Docker image details.
- **Deployed Application**: Running application status on the EC2 instance.

*Please see the screenshots below for detailed output examples.*
![jenkins-pipeline png](https://github.com/user-attachments/assets/11bce010-47f7-4078-84df-4be80f0a46b9)
![jenkins-dashboard png](https://github.com/user-attachments/assets/65550599-f17f-47e9-a2b5-7e5819c8408e)
![docker-hub-repo png](https://github.com/user-attachments/assets/16473bb3-c8ff-46f3-b0b6-00c5838ba044)
![container-output png](https://github.com/user-attachments/assets/77fccacc-16d2-497e-b461-2cfc0f0d2c73)
![Sonarqube png](https://github.com/user-attachments/assets/b0653334-927e-4532-b28e-c0aae03eb78b)

---
