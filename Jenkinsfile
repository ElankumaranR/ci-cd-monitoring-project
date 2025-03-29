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
        script {
            sh 'kubectl config use-context minikube'
            sh 'kubectl get nodes'
            sh 'kubectl apply -f k8s/deployment.yml --validate=false'
            sh 'kubectl apply -f k8s/service.yml --validate=false'
            sh 'minikube service springboot-service'
        }
    }
}
    }
}
