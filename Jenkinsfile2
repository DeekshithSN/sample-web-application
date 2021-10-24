#!/usr/bin/env groovy

@Library('shared-library@master') _ //master or whatever branch

pipeline{

      agent {
                docker {
                image 'maven:3-openjdk-11'
                args '-v $HOME/.m2:/root/.m2'
                }
            }
        
        stages{

              stage('maven build'){
                  steps{
                      script{
		    	                sh "mvn clean install"
                      	  }
               	     }  
                 }	
                 
                 stage ('Check logs') {
                    steps {
                        filterLogs ('WARNING', 50)
                    }
                }
		
           }	       	     	         
}
