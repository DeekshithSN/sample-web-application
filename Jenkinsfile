def getDockerTag(){
    def tag = sh script: 'git rev-parse --short HEAD', returnStdout: true
    return tag
  }


pipeline {
    agent any 

    environment{
      docker_tag = getDockerTag()
      docker_auth = credentials('docker-creds')
    }

    stages {

      stage ('execute paralelly'){
        parallel{
          // stage('sonarqube analysis'){

          //   agent {
          //     docker {
          //       image 'maven'
          //       args '-v $HOME/.m2:/root/.m2'
          //     }
          //   }  

          //   steps{
          //     script{
          //       withSonarQubeEnv('sonarqube') { 
          //           sh "printenv"
          //           sh "mvn sonar:sonar"
          //       }

          //       timeout(time: 1, unit: 'HOURS') {
          //                 def qg = waitForQualityGate()
          //                 if (qg.status != 'OK') {
          //                     error "Pipeline aborted due to quality gate failure: ${qg.status}"
          //         }
          //       }
          //     }
          //   }
          // }

          stage('maven build'){

            agent {
              docker {
                image 'maven'
                args '-v $HOME/.m2:/root/.m2'
              }
            }  

            steps {
              script {
                sh "mvn clean install"
              }
            }

          }
        }
      }

    stage("docker build"){
      steps{
        script{
          sh 'cp -r ../java-app-pipeline@2/target .'
          sh "docker build . -t deekshithsn/web-app:$docker_tag"
        }
      }
    }

    stage("docker push stage"){
      steps{
        script{
          sh """
              docker login -u $docker_auth_USR -p $docker_auth_PSW
              docker push deekshithsn/web-app:$docker_tag
          """
          currentBuild.description = "image name: deekshithsn/web-app:$docker_tag"
        }
      }
    }


    stage("deploying it to k8s cluster"){
      steps{
        script {
          configFileProvider([configFile(fileId: 'kube-config', variable: 'KUBECONFIG')]) {
            
            sh '''
            final_tag=$(echo $docker_tag | tr -d ' ')
            sed -i "s|IMAGE_NAME|deekshithsn/web-app:$final_tag|g" deployment.yaml
            kubectl apply -f deployment.yaml
            kubectl get po,svc
            '''
            addBadge(icon: 'info.gif', link: 'http://34.125.246.72:31884/')
          }
        }
      }

      post {
        always{
          archiveArtifacts artifacts: 'deployment.yaml', followSymlinks: false
        }
      }
    }

    }

    post{
      always{
        cleanWs()
      }
    }

}