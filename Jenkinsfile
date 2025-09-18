pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-id') // DockerHub credentials stored in Jenkins
        IMAGE_NAME = 'mahbeer/ecomm'
        KUBE_NAMESPACE = 'ecomm'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/thebbear7/Ecommerce-CICD.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$GIT_COMMIT -t $IMAGE_NAME:latest .'
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push $IMAGE_NAME:$GIT_COMMIT'
                sh 'docker push $IMAGE_NAME:latest'
    }
}

        stage('Deploy to EKS') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds-id'
                ]]) {
                    sh '''
                        aws eks update-kubeconfig --region ap-south-1 --name ecomm-cluster
                        kubectl apply -f k8s/namespace.yml
                        kubectl apply -f k8s/deployment.yml
             '''
                }
    }
}

    }
}
