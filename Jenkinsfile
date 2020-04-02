currentBuild.displayName = "Devops-Training"+currentBuild.number

pipeline{

    agent {
        docker {
        image 'maven'
        args '-v $HOME/.m2:/root/.m2'
        }
    }
   
stages{
    stage('sonar')
        {
      steps{
          script{
              withSonarQubeEnv('sonarserver') { 
          sh "mvn sonar:sonar"
              }
                }
            }
         }
    
    
      stage('Quality Gate Statuc Check'){
          steps{
              script{
          timeout(time: 1, unit: 'HOURS') {
              def qg = waitForQualityGate()
              if (qg.status != 'OK') {
                   error "Pipeline aborted due to quality gate failure: ${qg.status}"
              }
            }
          }
        }  
      }
    
    
    
      stage('build')
        {
      steps{
          script{
           sh 'mvn clean deploy'
                }
            }
         }
    
    
       }
}
