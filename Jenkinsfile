pipeline {
    agent any
    tools {
        go 'go-1.4'
    }
    environment {
        GO111MODULE = 'on'
    }
    stages {
        stage('Test') {
            steps {
                git 'https://github.com/ghassan1212/Repo_Jenkins.git'
                sh 'go test ./...'
            }
        }
    }
}
