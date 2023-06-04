pipeline {
    agent any
    
    environment {
          demo = 'environment'
    }
    
    options { 
        buildDiscarder(logRotator(numToKeepStr: '2')) 
    }

    stages {
        stage('clone'){
            
            environment {
                     stagename = 'clone-stage'
                     dockercreds = credentials("docker-hub-creds")
              }

            steps {
                script {
                    currentBuild.displayName = env.JOB_NAME + "#" +env.BUILD_NUMBER
                    currentBuild.description = env.GIT_COMMIT
                    echo "this is clone stage"
                    sh "printenv"
                    sh "docker login -u $dockercreds_USR -p $dockercreds_PSW"
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
