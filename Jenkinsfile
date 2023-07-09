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

        steps {
          script {
            sh "node -v "
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