pipeline {
    agent any
    environment{
      CC = 'clang'
      toolname = 'jenkins'
      dockerpass = credentials('docker-user-pass')
    }

    options{
      buildDiscarder(logRotator(numToKeepStr: '2'))
      timeout(time: 1, unit: 'MINUTES')
      timestamps()
    }

    parameters { 
      string(name: 'DEPLOY_ENV', defaultValue: 'staging', description: '') 
      choice(name: 'ENV', choices: ['dev', 'qa', 'prod'], description: '')
    }

    triggers { 
      pollSCM('H */4 * * 1-5')
    }

    stages{
      stage('Parallel Stage') { 
         parallel { 
          stage('docker login') {
            options {
                  retry (3)
                }
            
            steps {
              script {
                sh "echo clone stage"
                sh "docker login -u deekshithsn -p $dockerpass_PSW"
      
                currentBuild.description = "${env.GIT_COMMIT}"
              }
            }
          }


          stage('build') {
            agent {
              docker {
                image 'node'
              }
            }
            environment{
              place = 'bengaluru'
            }
            steps {
              script {
                sh "node -v "
                sh "printenv"
              }
            }
          }
        }
      }

      stage('deploy') {
        when { 
          anyOf {
          environment name: 'DEPLOY_ENV', value: 'production';
          environment name: 'GIT_BRANCH', value: 'master'
          }
        }
        agent {
          docker {
             image 'python'
          }
        }
        steps {
          script {
            sh "python -h > python.txt"
            sh "printenv"
          }
        }

        post{
          always{
              archiveArtifacts 'python.txt'
          }
        }
      }

    } 

    post{

      always {
        cleanWs()
      }

      success {
            echo "success"
           
      }

      failure {
          echo "failure"
      }

    }


}