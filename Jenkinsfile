pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'elankumaran21/springboot-app:latest'
    }
    stages {
        stage('Checkout') {
            steps {
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
                        def image = docker.build("${DOCKER_IMAGE}")
                        image.push()
                    }
                }
            }
        }

        stage('Setup Minikube') {
            steps {
                script {
                    sh 'minikube status || minikube start --driver=docker'
                    sh 'kubectl config use-context minikube'
                    sh 'kubectl get nodes'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh 'kubectl apply -f k8s/deployment.yml --validate=false'
                    sh 'kubectl apply -f k8s/service.yml --validate=false'
                    
                    // Wait for pod to be ready
                    sh '''
                    echo "Waiting for pods to be ready..."
                    kubectl wait --for=condition=ready pod -l app=springboot-app --timeout=120s
                    '''
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    sh 'kubectl get pods'
                    sh 'kubectl get svc springboot-service'
                    sh 'kubectl describe pod -l app=springboot-app'
                }
            }
        }
    }
}
