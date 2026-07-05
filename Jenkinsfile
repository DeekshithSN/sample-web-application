pipeline {
    agent {
      label 'linux'
    }

    stages{
     stage('Static code analysis') {
          steps {
              script {
                  // Securely inject the credentials you created
                 withSonarQubeEnv(credentialsId: 'sonarqube-token') {
                     sh "mvn sonar:sonar"
                 }
              }
          }
    }
  }
}