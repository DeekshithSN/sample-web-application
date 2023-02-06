   def getDockerTag(){
        def tag = sh script: 'git rev-parse HEAD', returnStdout: true
        return tag
        }

pipeline{
    agent any
    environment{
        Docker_tag = getDockerTag()
    }
    stages{
        stage("static code analysis"){
            agent {
                docker {
                    image 'maven'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-qube-token') {
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

        stage('build'){
            agent {
                docker {
                    image 'maven'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps{
                script{
                    sh "mvn clean install"
                }
            }
        }

        stage('docker build'){
            steps {
                script{
                    sh "docker build . -t deekshithsn/webapp:$Docker_tag"
                    currentBuild.description = "deekshithsn/webapp:$Docker_tag"
                }
            }
        }
    }
}