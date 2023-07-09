pipeline {
    agent any
    environment{
      CC = 'clang'
      toolname = 'jenkins'
    }

    stages{

      stage('clone') {
        agent {
          docker {
             image 'openjdk'
          }
        }

        steps {
          script {
            sh "echo clone stage"
            sh "java -version"
            sh "printenv"
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

      stage('deploy') {
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