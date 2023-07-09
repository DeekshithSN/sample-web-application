pipeline {
    agent any
    environment{
      CC = 'clang'
      toolname = 'jenkins'
      dockerpass = credentials('docker-user-pass')
    }

    stages{

      stage('docker login') {

        steps {
          script {
            sh "echo clone stage"
            sh "docker login -u deekshithsn -p ${env.dockerpass}"
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