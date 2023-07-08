pipeline {
    agent {
      label 'java'
    }

    stages{

      stage('clone') {
        steps {
          script {
            sh "echo clone stage"
          }
        }
      }


      stage('build') {
        steps {
          script {
            sh "echo build stage"
          }
        }
      }

      stage('deploy') {
        steps {
          script {
            sh "echo deploy stage"
          }
        }
        
      }

    } 
}