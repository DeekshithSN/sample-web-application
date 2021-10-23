pipeline{
    agent any
    stages{
        stage("Sonarqube analysis"){
            steps{
                script{
                withSonarQubeEnv(credentialsId: 'new_sonar') {
                      sh 'mvn sonar:sonar'
                  }

                   timeout(5) {
                      def qg = waitForQualityGate()
                      if (qg.status != 'OK') {
                           error "Pipeline aborted due to quality gate failure: ${qg.status}"
                      }
                    }
                }
            }
        }
        
        stage("Pushing the artifact to nexus"){
            steps{
                script{
                    sh 'mvn clean deploy'
                }
            }
        }
    }
    post{
        always{
          cleanWs()
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}
