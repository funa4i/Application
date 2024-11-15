pipeline {
    agent any  // «апуск на любом доступном агенте Jenkins

    environment {
        REPO_URL = 'https://github.com/funa4i/Application.git'
        BRANCH = 'master' 
    }

    stages {
        stage('Checkout') {
            steps {
                //  лонируем репозиторий из Git
                git url: "${REPO_URL}", branch: "${BRANCH}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // —троим Docker-образ, использу€ Dockerfile из репозитори€
                    //  оманда build будет искать Dockerfile в корневой директории проекта
                    sh 'docker build -t client .'
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                sh 'docker run -i client'
            }
        }
    }

    post {
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
