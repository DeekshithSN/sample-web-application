pipeline {
    agent any
    
    environment {
          demo = 'environment'
    }

    stages {
        stage('clone'){
            
            environment {
                     stagename = 'clone-stage'
                     docker-creds = credentials("docker-hub-creds")
              }

            steps {
                script {
                    currentBuild.displayName = env.JOB_NAME + "#" +env.BUILD_NUMBER
                    currentBuild.description = env.GIT_COMMIT
                    echo "this is clone stage"
                    sh "printenv"
                    sh "docker login -u $docker-creds_USR -p $docker-creds_PWS"
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
