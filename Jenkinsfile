pipeline {
    agent any 

    stages {

      stage('sonarqube analysis'){

        agent {
          docker {
            image 'maven'
          }
        }  

        steps{
          script{
            withSonarQubeEnv('sonarqube') { 
                sh "printenv"
                sh "mvn sonar:sonar"
            }
          }
        }
      }

    }
}