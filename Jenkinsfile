pipeline {
    agent any
    
    environment {
          demo = 'environment'
    }
    
    options { 
        buildDiscarder(logRotator(numToKeepStr: '2')) 
    
    }
    
    parameters { 
        string(name: 'DEPLOY_ENV', defaultValue: 'staging', description: '') 
        choice(name: 'CHOICES', choices: ['one', 'two', 'three'], description: '')
    }
    

    stages {
        
        stage('Parallel In Sequential') {
         parallel {
        stage('clone'){
            
            environment {
                     stagename = 'clone-stage'
          
              }

            steps {
                script {
                    currentBuild.displayName = env.JOB_NAME + "#" +env.BUILD_NUMBER
                    currentBuild.description = env.GIT_COMMIT
                    echo "this is clone stage"
                    echo "$params.DEPLOY_ENV"
                    echo "$params.CHOICES"
                    sh "sleep 60"
                    sh "printenv"
       
                }
            }
        }
        
        stage('download pre requesites'){
            steps {
                script {
                   sh "sleep 60"
                }
            }
        }
         }
        }

        stage('build'){
            agent {
                docker {
                   image 'python:3.7-buster'
                    
                }
            
            }
           
                steps {
                    script {
                         timeout(1) {
                            sh " python --version"
                        sh "printenv"
                    }
                }
            }
        }

        stage('deploy'){
            
             when { environment name: 'DEPLOY_ENV', value: 'production' }
             agent {
                
                docker {
                   image 'python:3.9-buster'
                }
            
            }
            
           
            steps {
                script {
                        sh " python --version"
                }
            }
        }
    }
    
    post{
        always{
          cleanWs()
        }
        
        failure {
           echo "pipeline failed will be sending failure mail"
        }
    }
}
