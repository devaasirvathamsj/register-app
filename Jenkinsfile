pipeline {
    agent {
        label 'jenkins-agent'
    }
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }
    environment {
        APP_NAME   = "register-app"
        RELEASE    = "1.0.0"
        AWS_REGION = "us-east-1"
        ECR_REPO   = "register-app"
        IMAGE_TAG  = "${RELEASE}-${BUILD_NUMBER}"
    }
    stages {
        stage("Cleanup Workspace") {
            steps {
                cleanWs()
            }
        }

        stage("Checkout from SCM") {
            steps {
                git branch: 'main', credentialsId: 'github-token', url: 'https://github.com/devaasirvathamsj/register-app.git'
            }
        }

        stage("Build Application") {
            steps {
                sh 'mvn clean package'
            }
        }

        stage("Test Application") {
            steps {
                sh 'mvn test'
            }
        }

        stage("SonarQube Analysis") {
            steps {
                withSonarQubeEnv(installationName: 'sonarqube-server', credentialsId: 'jenkins-sonarqube-token') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage("Quality Gate") {
            steps {
                waitForQualityGate abortPipeline: true, credentialsId: 'jenkins-sonarqube-token'
            }
        }

        stage("Resolve ECR Registry") {
            steps {
                script {
                    env.AWS_ACCOUNT_ID = sh(
                        script: "aws sts get-caller-identity --query Account --output text",
                        returnStdout: true
                    ).trim()
                    env.IMAGE_NAME = "${env.AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}"
                }
            }
        }

        stage("Build Docker Image") {
            steps {
                script {
                    def dockerImage = docker.build("${env.IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage("Trivy Scan") {
            steps {
                sh """
                    docker run \
                    -v /var/run/docker.sock:/var/run/docker.sock \
                    aquasec/trivy image ${env.IMAGE_NAME}:${IMAGE_TAG} \
                    --no-progress \
                    --scanners vuln \
                    --exit-code 0 \
                    --severity HIGH,CRITICAL \
                    --format table
                """
            }
        }

        stage("Push Docker Image to ECR") {
            steps {
                sh """
                    aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${env.AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                    docker push ${env.IMAGE_NAME}:${IMAGE_TAG}
                    docker tag ${env.IMAGE_NAME}:${IMAGE_TAG} ${env.IMAGE_NAME}:latest
                    docker push ${env.IMAGE_NAME}:latest
                """
            }
        }

        stage("Cleanup Docker Images") {
            steps {
                sh """
                    docker rmi ${env.IMAGE_NAME}:${IMAGE_TAG} || true
                    docker rmi ${env.IMAGE_NAME}:latest || true
                    docker system prune -af || true
                """
            }
        }

        stage("Trigger CD Pipeline") {
            steps {
                build job: 'gitops-register-app',
                      parameters: [string(name: 'IMAGE_TAG', value: "${IMAGE_TAG}")],
                      wait: false
            }
        }
    }

    post {
        failure {
            emailext body: "<p>Build <b>${env.JOB_NAME} #${env.BUILD_NUMBER}</b> failed.</p><p>Console output: <a href='${env.BUILD_URL}console'>${env.BUILD_URL}console</a></p>",
                     subject: "${env.JOB_NAME} - Build # ${env.BUILD_NUMBER} - Failed",
                     mimeType: 'text/html', to: "devaasirvathamsj@gmail.com"
        }
        success {
            emailext body: "<p>Build <b>${env.JOB_NAME} #${env.BUILD_NUMBER}</b> succeeded. Image tag: <b>${IMAGE_TAG}</b></p><p>Console output: <a href='${env.BUILD_URL}console'>${env.BUILD_URL}console</a></p>",
                     subject: "${env.JOB_NAME} - Build # ${env.BUILD_NUMBER} - Successful",
                     mimeType: 'text/html', to: "devaasirvathamsj@gmail.com"
        }
    }
}
