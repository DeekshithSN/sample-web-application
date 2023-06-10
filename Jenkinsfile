def getDockerTag(){
        def tag = sh script: 'git rev-parse HEAD', returnStdout: true
        return tag
      }

pipeline {
    agent any 

    environment{
	    Docker_tag = getDockerTag()
      Docker_Creds = credentials('dockerhub-creds')
    }

    stages {
        stage('static code anaylysis'){
            
            agent{
              docker{
                image 'maven:3.6.0'
              }
            }

            steps {
              script{
                withSonarQubeEnv(credentialsId: 'sonartoken') {
                  sh 'printenv'
                  sh "mvn sonar:sonar"
                }

                timeout(5){
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK'){
                            error "code didnt met qulaity gate"
                        }
                    }
              }
            }
        }

      stage('build') {

        agent{
              docker{
                image 'maven:3.6.0'
                args '-v /root/.m2:/root/.m2'
              }
            }

        steps{
          script{
            sh "mvn clean install"
          }
        }
      }

      stage('docker build & docker push') {
        steps{
          script{
            sh """
              cp -r ../complete-pipeline@2/target .
              docker build . -t deekshithsn/webapp-demo:$Docker_tag
              docker login -u $Docker_Creds_USR -p $Docker_Creds_PSW
              docker push deekshithsn/webapp-demo:$Docker_tag
            """
            currentBuild.description = "deekshithsn/webapp-demo:$Docker_tag"
            addBadge(icon: 'save.gif' , link: 'https://hub.docker.com/repository/docker/deekshithsn/webapp-demo/tags')
          }
        }
      }

    }
}