pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                echo 'Cloning the repo...'
            }
        }
        stage('Build') {
            steps {
                echo 'Running build steps...'
                sh './build.sh'
            }
        }
    }
}

