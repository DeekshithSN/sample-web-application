pipeline {
    agent any 

    stages {

      stage ('execute paralelly'){
        parallel{
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

                timeout(time: 1, unit: 'HOURS') {
                          def qg = waitForQualityGate()
                          if (qg.status != 'OK') {
                              error "Pipeline aborted due to quality gate failure: ${qg.status}"
                  }
                }
              }
            }
          }

          stage('maven build'){

            agent {
              docker {
                image 'maven'
                args '-v $HOME/.m2:/root/.m2'
              }
            }  

            steps {
              script {
                sh "mvn clean install"
              }
            }

          }
        }
      }

    stage("docker build"){
      steps{
        script{
          sh "docker build -t web-app ."
        }
      }
    }

    }
}