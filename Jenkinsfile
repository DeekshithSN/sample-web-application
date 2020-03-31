pipeline{

    agent {
        docker {
        image 'maven'
        args '-v $HOME/.m2:/root/m2'
        }
    }
   
stages{
    stage('build')
        {
      steps{
          script{
           sh 'mvn clean install'
                }
            }
         }
       }
    

}
