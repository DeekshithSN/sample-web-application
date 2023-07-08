pipeline {
    agent {
      label 'java'
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
            sh "python -h"
          }
        }
      }

    } 
}