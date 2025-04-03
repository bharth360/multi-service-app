pipeline {
    agent any
    environment {
        AWS_REGION = 'us-east-1'  
        ECR_REPO = 'react-frontend'
        AWS_ACCOUNT_ID = '009160053341'
        IMAGE_TAG = "react-frontend:${env.BUILD_NUMBER}"
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/bharth360/multi-service-app.git'
            }
        }

        stage('Login to AWS ECR') {
            steps {
                script {
                    sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${ECR_REPO}:${IMAGE_TAG} ./frontend"
                }
            }
        }

        stage('Tag Docker Image') {
            steps {
                script {
                    sh "docker tag ${ECR_REPO}:${IMAGE_TAG} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${IMAGE_TAG}"
                }
            }
        }

        stage('Push Image to ECR') {
            steps {
                script {
                    sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${IMAGE_TAG}"
                }
            }
        }

        stage('Clean Up') {
            steps {
                script {
                    sh "docker rmi ${ECR_REPO}:${IMAGE_TAG} || true"
                    sh "docker rmi ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${IMAGE_TAG} || true"
                }
            }
        }
    }
}
