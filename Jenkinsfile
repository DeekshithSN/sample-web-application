pipeline {
    agent any 

    stages {

      stage('sonarqube analysis'){

        agent {
          docker {
            image 'maven'
            args '-v $HOME/.m2:/root/.m2'
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