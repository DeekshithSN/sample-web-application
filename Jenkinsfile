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

                // timeout(5){
                //         def qg = waitForQualityGate()
                //         if (qg.status != 'OK'){
                //             error "code didnt met qulaity gate"
                //         }
                //     }

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
            currentBuild.description = "$Docker_tag"
            addBadge(icon: 'save.gif' , link: 'https://hub.docker.com/repository/docker/deekshithsn/webapp-demo/tags')
          }
        }
      }

      stage('approval stage') {
        steps{
          script{
             timeout(5){
                        // mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "${currentBuild.result} CI: Project name -> ${env.JOB_NAME}", to: "deekshithsn@gmail.com";
                        input( message: "Deploy ${params.project_name}?", ok: 'Deploy')
                    }
          }
        }
      }

      stage('deploy stage'){
        steps{
          script{
            sh '''
            final_tag=$(echo $Docker_tag | tr -d ' ')
            sed -i "s;IMAGE_NAME;deekshithsn/webapp-demo:$final_tag;" deployment.yaml
            cat deployment.yaml
            '''
          }
        }
      }


       stage('deploy to k8s cluster'){
            steps{
                script{
                    configFileProvider([configFile(fileId: 'kube-dev-config', variable: 'KUBECONFIG')]) {
                        sh '''
                            kubectl apply -f deployment.yaml
                        '''
                    }
                }
            }
       }

    }
}