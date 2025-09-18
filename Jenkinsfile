pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-id') // DockerHub credentials stored in Jenkins
        IMAGE_NAME = 'your-dockerhub-username/frontend-app'
        KUBE_NAMESPACE = 'frontend'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/thebbear7/Ecommerce-CICD.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$GIT_COMMIT .'
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin'
                sh 'docker push $IMAGE_NAME:$GIT_COMMIT'
            }
        }

        stage('Deploy to EKS') {
            steps {
                // Assumes kubectl is configured to point to your existing EKS cluster
                sh 'kubectl apply -f k8s/namespace.yaml'
                sh 'kubectl apply -f k8s/deployment.yaml'
                sh 'kubectl apply -f k8s/service.yaml'
            }
        }
    }
}
