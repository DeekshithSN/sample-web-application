pipeline {
    agent {
      label 'java'
    }

    stages{

      stage('clone') {
        agent {
          docker {
             image '8u111-jdk-alpine'
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
            sh "node -version "
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
            sh "python -version"
          }
        }
      }

    } 
}