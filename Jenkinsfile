pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                // Checkout your repository from GitHub
                git branch: 'main', url: 'https://github.com/ElankumaranR/ci-cd-monitoring-project.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
stage('Docker Build & Push') {
    steps {
        script {
            docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                def image = docker.build('elankumaran21/springboot-app:latest')
                image.push()
            }
        }
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
