pipeline{
    agent{
        label 'jenkins-agent'
    }
    tools{
        jdk 'Java17'
        maven 'Maven3'
    }
    stages{
        stage("Cleanup workspace"){
            steps{
                cleanWs()
            }
        }
        
        stage("Checkout from SCM"){
            steps{
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/devaasirvathamsj/register-app.git'
            }
        }

        stage("Build application"){
            steps{
                sh "mvn clean package"
            }
        }
        stage("Test application"){
            steps{
                sh "mvn test"
            
            }
        }
        
    }
}
