pipeline {
    agent any

    tools {
        maven 'M3'  // Utilise Maven avec l'ID 'M3' (doit être configuré dans Jenkins)
        jdk 'JDK17' // Utilise JDK 17 avec l'ID 'JDK17' (doit être configuré dans Jenkins)
    }

    environment {
        // Configuration pour Slack (optionnel - commenté si non configuré)
        // SLACK_WEBHOOK_URL = credentials('slack-webhook-url')
        SLACK_CHANNEL = '#devops-notifications'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from GitHub...'
                checkout scm
                sh 'git branch'
                sh 'git log --oneline -5'
            }
        }

        stage('Build') {
            steps {
                echo 'Building the application with Maven...'
                dir('devops-app') {
                    sh 'mvn clean compile'
                }
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                dir('devops-app') {
                    sh 'mvn test'
                }
            }
            post {
                always {
                    junit 'devops-app/target/surefire-reports/*.xml'
                }
            }
        }

        stage('Package') {
            steps {
                echo 'Packaging the application...'
                dir('devops-app') {
                    sh 'mvn package -DskipTests'
                }
            }
        }

        stage('Archive') {
            steps {
                echo 'Archiving artifacts...'
                archiveArtifacts artifacts: 'devops-app/target/*.jar', fingerprint: true
            }
        }

        stage('Deploy') {
            when {
                expression {
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                echo 'Deploying the application...'
                script {
                    // Option 1: Déploiement local (copie du JAR)
                    sh 'mkdir -p deploy'
                    sh 'cp devops-app/target/*.jar deploy/'
                    
                    // Option 2: Déploiement avec Docker (si configuré)
                    // sh 'docker build -t devops-app:${BUILD_NUMBER} -f Dockerfile .'
                    // sh 'docker-compose up -d'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded!'
            script {
                // Notification Slack en cas de succès
                slackSend(
                    channel: env.SLACK_CHANNEL,
                    color: 'good',
                    message: """
                        ✅ *Pipeline réussi!*
                        *Projet:* ${env.JOB_NAME}
                        *Build #:* ${env.BUILD_NUMBER}
                        *Branche:* ${env.GIT_BRANCH}
                        *Statut:* Succès
                        *Console:* ${env.BUILD_URL}
                    """
                )
            }
        }
        failure {
            echo 'Pipeline failed!'
            script {
                // Notification Slack en cas d'échec
                slackSend(
                    channel: env.SLACK_CHANNEL,
                    color: 'danger',
                    message: """
                        ❌ *Pipeline échoué!*
                        *Projet:* ${env.JOB_NAME}
                        *Build #:* ${env.BUILD_NUMBER}
                        *Branche:* ${env.GIT_BRANCH}
                        *Statut:* Échec
                        *Console:* ${env.BUILD_URL}
                    """
                )
            }
        }
        always {
            echo 'Pipeline completed. Cleaning up...'
            cleanWs()
        }
    }
}

