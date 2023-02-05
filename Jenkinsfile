pipeline{
    agent none
    stages{
        stage("static code analysis"){
            agent {
                docker {
                    image 'maven'
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
                }
            }
            steps{
                script{
                    sh "mvn clean install"
                }
            }
        }
    }
}