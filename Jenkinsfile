pipeline{
    agent any
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
    }

    post {
        always{
            cleanWs()
        }
    }
}