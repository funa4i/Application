pipeline {
    agent any  // ������ �� ����� ��������� ������ Jenkins

    environment {
        REPO_URL = 'https://github.com/funa4i/Application.git'
        BRANCH = 'master' 
    }

    stages {
        stage('Checkout') {
            steps {
                // ��������� ����������� �� Git
                git url: "${REPO_URL}", branch: "${BRANCH}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // ������ Docker-�����, ��������� Dockerfile �� �����������
                    // ������� build ����� ������ Dockerfile � �������� ���������� �������
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
