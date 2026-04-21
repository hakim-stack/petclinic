# 🚀 DevOps Project – Microservices Deployment on AWS EKS

## 📌 Description
Ce projet consiste à déployer une application microservices (Spring PetClinic) sur AWS en utilisant une approche DevOps complète : Infrastructure as Code, conteneurisation, orchestration Kubernetes et CI/CD.

L'objectif est de mettre en place une architecture scalable, automatisée et supervisée, proche des standards utilisés en entreprise.

---

## 🏗️ Architecture

- Cloud : AWS (EKS)
- Infrastructure as Code : Terraform
- Orchestration : Kubernetes
- Conteneurisation : Docker
- CI/CD : AWS CodeBuild / CodePipeline
- Monitoring : Prometheus & Grafana

---

## ⚙️ Fonctionnalités

- Déploiement automatisé d’un cluster Kubernetes (EKS)
- Provisioning réseau (VPC, subnets, etc.) avec Terraform
- Déploiement de microservices Spring Boot
- Mise en place d’un API Gateway
- Pipeline CI/CD pour automatiser les déploiements
- Supervision des services avec Prometheus et Grafana

---

## 📁 Structure du projet

```
.
├── terraform-config/        # Infrastructure AWS (EKS, VPC…)
├── k8s-manifests/          # Déploiements Kubernetes
├── prometheus/             # Configuration monitoring
├── spring-petclinic-*      # Microservices
├── buildspec-*.yml         # CI/CD AWS
├── docker-compose.yml      # Tests locaux
└── scripts/                # Scripts automatisation
```

---

## 🚀 Déploiement

### 1. Initialisation Terraform
```bash
terraform init
terraform plan
terraform apply
```

### 2. Configuration kubectl
```bash
aws eks update-kubeconfig --region eu-west-3 --name <cluster-name>
```

### 3. Déploiement des services
```bash
kubectl apply -f k8s-manifests/
```

---

## 📊 Monitoring

- Prometheus pour la collecte des métriques  
- Grafana pour la visualisation  

---

## 🎯 Objectifs du projet

- Maîtriser Kubernetes sur AWS (EKS)  
- Automatiser l’infrastructure avec Terraform  
- Mettre en place un pipeline CI/CD complet  
- Superviser une architecture microservices  

---

## 👨‍💻 Auteur

Hakim Aichi
