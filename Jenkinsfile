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

                 timeout(time: 1, unit: 'HOURS') {
                      def qg = waitForQualityGate()
                      if (qg.status != 'OK') {
                           error "Pipeline aborted due to quality gate failure: ${qg.status}"
                      }
                  }
              }
          }
    }
  }
}