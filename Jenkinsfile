pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh docker build -t needchange:latest

            }
        }
        stage('Test') {
            steps {
                sh docker run --rm needchange:latest /bin/sh -c echo "test passed"

            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}