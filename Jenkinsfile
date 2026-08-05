pipeline {
    agent {
        label 'jenkins-agent'
    }
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }
    environment {
        APP_NAME = "register-app-1"
        RELEASE = "1.0.0"
        AWS_ACCOUNT_ID = "<your-account-id>"
        AWS_REGION = "<your-region>"
        ECR_REPO = "register-app"
        IMAGE_NAME = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
        JENKINS_API_TOKEN = credentials('jenkins-api-token')
    }
    stages {
        stage("Cleanup Workspace") {
            steps {
                cleanWs()
            }
        }
        stage("Checkout from SCM") {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/devaasirvathamsj/register-app.git'
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
                waitForQualityGate abortPipeline: true
            }
        }
        stage("Build Docker Image") {
            steps {
                script {
                    docker_image = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }
        stage("Trivy Scan") {
            steps {
                sh """
                docker run \
                -v /var/run/docker.sock:/var/run/docker.sock \
                aquasec/trivy image ${IMAGE_NAME}:${IMAGE_TAG} \
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
                aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                docker push ${IMAGE_NAME}:${IMAGE_TAG}
                docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest
                docker push ${IMAGE_NAME}:latest
                """
            }
        }
        stage("Cleanup Docker Images") {
            steps {
                sh """
                docker rmi ${IMAGE_NAME}:${IMAGE_TAG} || true
                docker rmi ${IMAGE_NAME}:latest || true
                docker system prune -af || true
                """
            }
        }
    }
}
