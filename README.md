# 🌐 Static Resume Website with Visitor Counter — AWS + Terraform + CI/CD


## 📜 Overview
This project demonstrates a fully automated static resume website, deployed on AWS, with a real-time visitor counter — using serverless technologies, Infrastructure as Code (IaC), and CI/CD pipelines.

The site is served securely over HTTPS, uses a custom domain, and is built using:

+ AWS S3 (static site hosting)

+ CloudFront (CDN + SSL)

+ Route 53 (DNS)

+ API Gateway + Lambda (Visitor Counter API)

+ DynamoDB (visitor count store)

+ Terraform (IaC)

+ GitHub Actions (CI/CD)

Live site: https://autocloudmate.com


- Static Resume Website with custom design
- Real-time Visitor Counter with Serverless API
- Fully automated CI/CD pipeline
- HTTPS with CloudFront and SSL
- Custom domain with Route 53
- Terraform-managed infrastructure
- GitHub Actions for auto-deploy
- Serverless, scalable, and low-cost

## ⚙️ Tech Stack
- Component Technology
- Hosting	AWS S3
- CDN + HTTPS	AWS CloudFront
- DNS	AWS Route 53
- API	AWS API Gateway
- Backend (Serverless)	AWS Lambda (Python + boto3)
- Database	DynamoDB (on-demand)
- IaC	Terraform
- CI/CD	GitHub Actions
- Security	GitHub Secrets, IAM roles

## 🌍 Website Workflow
Visitor opens the site: 
1. CloudFront serves static content from S3

2. Frontend JS triggers /visitor API via API Gateway

3. Lambda updates and fetches visitor count from DynamoDB

4. Result is displayed on the site dynamically

## 🛠️ Infrastructure as Code
Infrastructure is fully automated using Terraform (infra/main.tf), including:

- S3 Bucket (existing)
- CloudFront cache invalidation
- Serverless API + Lambda + DynamoDB
- Variables and reusability for multi-region support

## 🔄 CI/CD Pipeline
GitHub Actions automates:

-  Terraform apply
-  S3 sync (HTML, CSS, JS upload)
-  CloudFront cache invalidation

Workflow: .github/workflows/terraform-deploy.yml

On every push to main:

- terraform init
- terraform apply
- aws s3 sync . s3://autocloudmate --delete
- aws cloudfront create-invalidation --distribution-id E37CM87UA02ZMU --paths "/*"

AWS credentials are securely stored in GitHub Secrets.

## 📈 Visitor Counter
The visitor counter API is built with:
* AWS Lambda (Python)
* DynamoDB (stores count)
* API Gateway (serves endpoint /visitor)
* JavaScript frontend (AJAX calls to API)

Simple, lightweight, and serverless with potential for future features: IP-based counting, session tracking, geo-location analytics.

## 💡 What This Project Demonstrates
- Core AWS Services proficiency
- Serverless application development
- DevOps CI/CD pipeline with GitHub Actions
- Infrastructure as Code with Terraform
- Secure, automated deployments
- Real-world use of AWS Free Tier
- Cloud cost optimization practices

## 📝 How to Deploy This Project
Clone the repo:
```git
git clone https://github.com/yourusername/aws-resume-site.git
```
```bash 
cd aws-resume-site 
```
Initialize Terraform:
```
cd infra
```
```
terraform init
```
```
terraform apply
```
Push your changes:

```
git add .
```
```
git commit -m "Initial deploy"
````
```
git push origin main
```
Done! The pipeline runs automatically on GitHub Actions and your live site updates.

## 🔐 Security Best Practices
- AWS credentials are never hard-coded

- GitHub Secrets used in workflows

- S3 bucket restricted to CloudFront origin only

- HTTPS enforced via CloudFront

- No manual console deployments — fully IaC

## 🔮 Possible Improvements
- Migrate Terraform state to S3 backend with locking

- Add unit tests to Lambda (pytest)

- Use CloudWatch for detailed Lambda metrics

- Support multiple environments (prod/stage)

- Add pre-prod preview deployment using GitHub Pages

## 📚 Resources
- AWS Free Tier

- Terraform AWS Provider

- GitHub Actions

## 🔗 Live Demo
👉 https://autocloudmate.com

## 📜 License
MIT © 2025 Ashok Nath
