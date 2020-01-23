pipeline {
    agent any
    
    tools {
        maven 'M3'
    }
    
    stages {
        stage ('Checkout') {
            steps {
                sh 'echo "--=-- Checkout stage --=--"'
                git url:'https://github.com/Formation67/simple_boot.git'
            }
        }
        stage ('Compile') {
            steps {
                sh 'echo "--=-- Compile Stage --=--"'
                sh 'mvn clean compile'
            }
        }
        stage ('Test') {
            steps {
                sh 'echo "--=-- Test Stage --=--"'
                sh 'mvn test'
                junit '**/target/surefire-reports/TEST-*.xml'
            }
        }
        stage ('Package') {
            steps {
                sh 'echo "--=-- Package Stage --=--"'
                sh 'mvn package'
            }
        }
    }
}