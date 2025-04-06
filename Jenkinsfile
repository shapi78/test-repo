pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'docker build -t needchange .'
                sh ' docker tag needchange localhost:5000/needchange'
                sh ' docker push localhost:5000/needchange'

            }
        }
        stage('Test') {
            steps {
              //  sh 'docker run --rm needchange:latest /bin/sh -c echo "test passed"'
                echo 'Deploying....'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}