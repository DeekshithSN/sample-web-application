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
                    docker build -t 34.125.26.221:8083/sample-app:$Docker_tag .
                    """

                }
            }
        }


    }

    post {
        always{
            cleanWs()
        }
    }
}