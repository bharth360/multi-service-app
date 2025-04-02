pipeline {
    agent any

    environment {
        COMPOSE_FILE = "docker-compose.yml"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', credentialsId: 'github-credentials', url: 'https://github.com/bharth360/multi-service-app.git'
            }
        }

        stage('Build Docker Images') {
            steps {
                sh 'docker compose build'
            }
        }

        stage('Deploy Services') {
            steps {
                sh 'docker compose up -d'
            }
        }

        stage('Health Check') {
            steps {
                sh 'curl -f http://localhost || exit 1'
            }
        }
    }

    post {
        failure {
            mail to: 'bharateshshanavad@gmail.com',
                 subject: '🚨 Jenkins Deployment Failed!',
                 body: 'The latest deployment of multi-service-app failed. Check Jenkins logs for details.'
        }
    }
}
