pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/YOUR_GITHUB_USERNAME/multi-service-app.git'
            }
        }

        stage('Build and Deploy') {
            steps {
                sh 'docker-compose down'
                sh 'docker-compose up -d --build'
            }
        }
    }

    post {
        failure {
            mail to: 'bharateshshanavad@gmail.com',
                 subject: "Deployment Failed",
                 body: "The deployment failed. Please check Jenkins logs for details."
        }
    }
}

