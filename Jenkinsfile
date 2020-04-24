pipeline{

      agent {
                docker {
                image 'maven'
                args '-v $HOME/.m2:/root/.m2'
                }
            }
        
        stages{

              stage('Quality Gate Status Check'){
                  steps{
                      script{
		    	    sh "mvn clean install"
                 	}

               	 }  
              }	
		
            }	       	     	         
}
