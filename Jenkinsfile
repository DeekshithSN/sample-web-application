pipeline{
        agent any  
        environment{
	   
        }
        
        stages{
              stage('build')
                {
              steps{
                  script{
		      docker.withRegistry('https://hub.docker.com/', 'docker_credentials') {
                      image = docker.image('terraform:1.0')
                      image.pull()
                       }
                       }
                    }
                 }		
               }    
}
