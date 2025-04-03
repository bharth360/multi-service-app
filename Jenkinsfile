pipeline {
    agent any
    
    parameters {
        string(name: 'TAG', defaultValue: 'latest', description: 'Tag for the Docker image')
    }

    environment {
        AWS_REGION = 'us-east-1'  
        ECR_REPO = 'react-frontend'
        AWS_ACCOUNT_ID = '009160053341'
        IMAGE_TAG = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${TAG}"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', credentialsId: 'github-ssh', url: 'https://github.com/bharth360/multi-service-app.git'
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
                    sh "docker build -t ${ECR_REPO} ."
                }
            }
        }

        stage('Tag Docker Image') {
            steps {
                script {
                    sh "docker tag ${ECR_REPO} ${IMAGE_TAG}"
                }
            }
        }

        stage('Push Image to ECR') {
            steps {
                script {
                    sh "docker push ${IMAGE_TAG}"
                }
            }
        }

        stage('Clean Up') {
            steps {
                script {
                    sh "docker rmi ${ECR_REPO} || true"
                    sh "docker rmi ${IMAGE_TAG} || true"
                }
            }
        }
    }
}
