pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh docker build -t localhost:5000/py-20250403072009

            }
        }
        stage('Test') {
            steps {
                sh docker run --rm localhost:5000/py-20250403072009 /bin/bash -c echo "test passed"

            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}