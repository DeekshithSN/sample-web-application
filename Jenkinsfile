pipeline {
  agent any 
  tools {
    maven "maven"
    jdk "jdk11"
  }



  stages {
    stage('Fetch Code') {
      steps { 
        git branch: 'main', url: 'https://github.com/Filip3Kx/sample-web-application-CI'
      }
    }
    stage('Build') {
      steps {
        sh 'mvn install -DskipTests'
      }
      post {
        success {
            echo 'Archiving artifacts...'
            archiveArtifacts artifacts: '**/*.war'
        }
      }
    }
    stage('UNIT TESTS') {
      steps {
        sh 'mvn test'
      }
    }
  }
}