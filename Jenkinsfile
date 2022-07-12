def getDockerTag() {
 def tag = sh script: 'git rev-parse HEAD', returnStdout: true 
 return tag
}
pipeline{

      agent {
                docker {
                image 'maven:3.8.1-adoptopenjdk-11'
                args '-v $HOME/.m2:/root/.m2'
                }
             }
      environment {
          Docker_tag = getDockerTag()
      }
        
        stages{

              stage('Quality Gate Status Check'){
                  steps{
                      script{
			      withSonarQubeEnv('sonarserver') { 
			      sh "mvn sonar:sonar"
                       	     	}
			      timeout(time: 1, unit: 'HOURS') {
			      def qg = waitForQualityGate()
				      if (qg.status != 'OK') {
					   error "Pipeline aborted due to quality gate failure: ${qg.status}"
				      }
                    		}
		    	    sh "mvn clean install"
		  
                 	}
               	 }  
              }	

              stage('build'){
		      steps {
			      script{
					 sh 'cp -r ../Devops_Life@2/target .'
                 			 sh 'docker build . -t naziyashaik/sample-web-app:$Docker_tag'
		 				withCredentials([string(credentialsId: 'passwd', variable: 'docker_password')]) {		    
			  			sh 'docker login -u naziyashaik -p $docker_password'
						sh 'docker push naziyashaik/sample-web-app:$Docker_tag'
                }
                
			      }
		      }
              }
		
            }	       	     	         
}
