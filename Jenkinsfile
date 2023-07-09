pipeline {
    agent any
    environment{
      CC = 'clang'
      toolname = 'jenkins'
      dockerpass = credentials('docker-user-pass')
    }

    options{
      buildDiscarder(logRotator(numToKeepStr: '2'))
    }

    stages{

      stage('docker login') {
        options {
              retry (3)
            }
        steps {
          script {
            sh "echo clone stage"
            sh "docker login -u ghjjjj -p $dockerpass_PSW"
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