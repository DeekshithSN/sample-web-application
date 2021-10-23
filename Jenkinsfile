pipeline{
    agent any
    stages{
        stage("Sonarqube analysis"){
            steps{
                script{
                withSonarQubeEnv(credentialsId: 'new_sonar') {
                      sh 'mvn sonar:sonar' 
                  }
                }
            }
        }
    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}
