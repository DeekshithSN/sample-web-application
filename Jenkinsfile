def getDockerTag(){
    def tag = sh script: 'git rev-parse --short HEAD', returnStdout: true
    return tag
    }

pipeline{
    agent any
    environment{
        Docker_tag = getDockerTag()
    }
    stages{
        stage("Sonar scan"){
            agent {
                docker {
                    image 'maven'
                    args '-v /root/.m2:/root/.m2'
                }
            }
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                            sh 'printenv'
                            sh 'mvn sonar:sonar'
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

        stage('build the application'){
            agent {
                docker {
                    image 'maven'
                    args '-v /root/.m2:/root/.m2'
                }
            }
            steps{
                script{
                    sh "mvn clean deploy"
                }
            }
        }

        stage('docker login and build'){
            steps{
                script{
                    sh """
                    docker login -u admin -p admin 34.125.26.221:8083
                    cp -r ../ci-pull-request@2/target .
                    docker build . -t 34.125.26.221:8083/sample-web-app:$Docker_tag
                    docker push 34.125.26.221:8083/sample-web-app:$Docker_tag
                    """

                }
            }
        }

        stage('prepare deplyment file'){
            steps{
                script{
                    sh '''
                    final_tag=$(echo $Docker_tag | tr -d ' ')
                    sed -i "s|TAG|$final_tag|" deployment.yaml
                    cat deployment.yaml
                    '''
                }
            }
        }
        stage('connect k8s cluster'){
            steps{
                script{
                    configFileProvider(
                        [configFile(fileId: 'kube-config-file', variable: 'KUBECONFIG')]) {
                        sh """
                         kubectl get po
                         kubectl apply -f deployment.yaml
                         """
                    }
                }
            }
        }


    }

    post {
        always{
            cleanWs()
            sh 'kubectl delete -f deployment.yaml'
        }
    }
}