# 🍽️ DineDash — DevSecOps CI/CD Pipeline

A food delivery & restaurant discovery web application built with **ReactJS**, containerized with **Docker**, and deployed through a fully automated **DevSecOps CI/CD pipeline** using Jenkins, SonarQube, OWASP, and Trivy.

---

## 🏗️ Architecture Overview

```
Developer Push → GitHub → Jenkins Pipeline
    → SonarQube Analysis → Quality Gate
    → OWASP Dependency Check
    → Docker Build → Trivy Image Scan
    → Push to DockerHub → Deploy to AWS EC2
    → Access via http://<EC2-IP>
```

---

## 🛠️ Tech Stack

| Layer | Tool |
|-------|------|
| Frontend | ReactJS 18, SCSS, Material UI |
| Containerization | Docker (multi-stage, Node 20 + Nginx) |
| CI/CD | Jenkins |
| Code Quality | SonarQube |
| Dependency Security | OWASP Dependency-Check |
| Image Security | Trivy |
| Container Registry | DockerHub |
| Cloud | AWS EC2 |

---

## 📂 Project Structure

```
dinedash-/
├── public/                   # Static HTML + favicon
├── src/
│   ├── components/
│   │   ├── Header/           # Navigation + search bar + mobile menu
│   │   ├── Card/             # 3-card section (Order Online, Nightlife, Dining)
│   │   ├── Collections/      # Curated restaurant collections
│   │   ├── Cities/           # Popular localities section
│   │   ├── CTA/              # App download call-to-action
│   │   ├── AccContainer/     # Accordion section wrapper
│   │   ├── Accordian/        # Expandable FAQ accordion
│   │   └── Footer/           # Full-width site footer
│   ├── assets/images/        # All image assets
│   ├── App.js                # Root component
│   ├── app.scss              # Global SCSS styles
│   ├── data.js               # Accordion data (cuisines, types, chains)
│   └── index.js              # React entry point
├── Dockerfile                # Multi-stage build: Node 20 → Nginx
├── nginx.conf                # Nginx config (SPA routing + security headers)
├── Jenkinsfile               # Full DevSecOps CI/CD pipeline (12 stages)
├── sonar-project.properties  # SonarQube configuration
├── .env.example              # Environment variable template
├── Kubernetes/               # K8s manifests (deployment + services)
└── package.json              # Node.js dependencies
```

---

## 🚀 Quick Start (Local Development)

```bash
# 1. Clone the repository
git clone https://github.com/your-username/dinedash-.git
cd dinedash-

# 2. Install dependencies
npm install

# 3. Start development server
npm start
# App runs at http://localhost:3000
```

---

## 🐳 Docker (Local)

```bash
# Build the image
docker build -t dinedash:latest .

# Run the container
docker run -d -p 80:80 --name dinedash dinedash:latest

# Access at http://localhost
```

---

## 🔧 Jenkins Pipeline — Setup Guide

### Prerequisites on Jenkins Server

1. **Install plugins:** Git, NodeJS, SonarQube Scanner, OWASP Dependency-Check, Docker Pipeline, SSH Agent, Email Extension
2. **Configure tools in Manage Jenkins → Tools:**
   - JDK: `jdk17`
   - NodeJS: `node23`
   - SonarQube Scanner: `sonar-scanner`
   - OWASP DC: `DP-Check`
3. **Add credentials:**
   - `Sonar-token` — SonarQube token (Secret text)
   - `docker` — DockerHub username/password
   - `ec2-ssh-key` — EC2 SSH private key (.pem)

### Environment Variables to Update in `Jenkinsfile`

| Variable | What to Set |
|----------|-------------|
| `DOCKERHUB_USERNAME` | Your DockerHub username |
| `EC2_HOST` | Your EC2 instance public IP |
| `EMAIL_RECIPIENT` | Your notification email address |
| Git URL in `Git Checkout` stage | Your actual GitHub repo URL |

---

## 🔐 DevSecOps Pipeline Stages

| Stage | Tool | Purpose |
|-------|------|---------|
| 1. Clean Workspace | Jenkins | Remove stale files |
| 2. Git Checkout | Git | Pull latest code |
| 3. SonarQube Analysis | SonarQube | Static code analysis |
| 4. Quality Gate | SonarQube | Block bad code |
| 5. Install Dependencies | npm | Install packages |
| 6. OWASP Dependency Check | OWASP DC | CVE scan of dependencies |
| 7. Trivy FS Scan | Trivy | Filesystem vulnerability scan |
| 8. Docker Build | Docker | Build production image |
| 9. Trivy Image Scan | Trivy | Image vulnerability scan |
| 10. Push to DockerHub | Docker | Store image |
| 11. Deploy to EC2 | SSH + Docker | Run on cloud |
| 12. (Optional) Terminate EC2 | AWS CLI | Cost optimization |

---

## ☸️ Kubernetes Deployment

```bash
# Deploy to a Kubernetes cluster
kubectl apply -f Kubernetes/deployment.yaml
kubectl apply -f Kubernetes/service.yaml

# Check status
kubectl get pods
kubectl get svc
# App accessible on NodePort 30001
```

---

## 📋 Required Jenkins Plugins

- Git Plugin
- NodeJS Plugin
- SonarQube Scanner Plugin
- OWASP Dependency-Check Plugin
- Docker Pipeline Plugin
- SSH Agent Plugin
- Email Extension Plugin

---

## ⚠️ Important Notes

- The old `jenkinsfile` (lowercase) is now replaced by `Jenkinsfile` (capital J) — Jenkins requires this exact casing.
- The Docker image now uses **Nginx** (port 80) instead of the dev server (port 3000).
- `project_context.md` is in `.gitignore` and will not be committed.

---

*Built for DevSecOps learning & demonstration purposes.*
