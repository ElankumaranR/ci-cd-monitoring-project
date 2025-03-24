pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                // Checkout your repository from GitHub
                git  git branch: 'main', url: 'https://github.com/ElankumaranR/ci-cd-monitoring-project.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Docker Build & Push') {
            steps {
                // Build Docker image and push it to Docker Hub
                sh 'docker build -t elankumaran21/springboot-app:latest .'
                sh 'docker push elankumaran21/springboot-app:latest'
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yml'
                sh 'kubectl apply -f k8s/service.yml'
            }
        }
    }
}
