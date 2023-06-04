pipeline {
    agent any
    
    environment {
          demo = 'environment'
    }

    stages {
        stage('clone'){
            
            environment {
                     stagename = 'clone-stage'
              }

            steps {
                script {
                    currentBuild.displayName = env.JOB_NAME + "#" +env.BUILD_NUMBER
                    echo "this is clone stage"
                    sh "printenv"
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
                        sh " python --version"
                    sh "printenv"
                }
            }
        }

        stage('deploy'){
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
