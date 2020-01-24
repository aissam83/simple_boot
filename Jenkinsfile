pipeline {
    agent any
    
    tools {
        maven 'M3'
    }
    
    stages {
        stage ('Cleaning workspace'){
            steps {
                sh 'echo "--=-- Cleaning stage --=--"'
                sh 'mvn clean'
                script {
                    try {
                        sh 'docker stop simple-boot  && docker rm simple-boot'
                    } catch (Exception e) {
                        sh 'echo "--=-- No container to remove --=--"'
                    }
                }
                script {
                    try {
                        sh 'docker rmi simple-boot'
                    } catch (Exception e) {
                        sh 'echo "--=-- No image to remove --=--"'
                    }
                }
            }
        }
        stage ('Checkout') {
            steps {
                sh 'echo "--=-- Checkout stage --=--"'
                git url:'https://github.com/Formation67/simple_boot.git'
            }
        }
        stage ('Compile') {
            steps {
                sh 'echo "--=-- Compile Stage --=--"'
                sh 'mvn compile'
            }
        }
        stage ('Test') {
            steps {
                sh 'echo "--=-- Test Stage --=--"'
                sh 'mvn test'
                junit '**/target/surefire-reports/TEST-*.xml'
            }
        }
        stage ('Code coverage') {
            steps {
                jacoco (
                    execPattern: 'target/*.exec',
                    classPattern: 'target/classes',
                    sourcePattern: 'src/main/java',
                    exclusionPattern: 'src/test*'
                )
            }
        }
        stage ('Sanity check') {
            steps {
                sh 'echo "--=-- Sanity check test projet --=--"'
                sh 'mvn checkstyle:checkstyle pmd:pmd'
            }
            post {
                always {
                    recordIssues enabledForFailure: true, tools: [checkStyle()]
                    recordIssues enabledForFailure: true, tool: pmdParser(pattern: '**/target/pmd.xml')
                }
            }
        }
        stage ('Package') {
            steps {
                sh 'echo "--=-- Package Stage --=--"'
                sh 'mvn package'
            }
        }
        stage ('Docker Build') {
            steps {
                sh 'echo "--=-- Build Docker Image --=--"'
                sh 'docker build -t simple-boot .'
            }            
        }
        stage ('Deploy Application') {
            steps {
                sh 'echo "--=-- Deploying Docker Image --=--"'
                sh 'docker run -d --name=simple-boot -p 8180:8080 simple-boot'
            }
        }
        
    }
}