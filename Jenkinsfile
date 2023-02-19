def getDockerTag(){
    def tag = sh script: 'git rev-parse --short HEAD', returnStdout: true
    return tag
    }

pipeline{
    agent any
    environment{
        Docker_tag = getDockerTag()
        docker_pws = credentials('docker-password')
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

        stage('docker build'){
            steps{
                script{
                    sh """
                    cp -r ../$JOB_BASE_NAME@2/target .
                    docker build . -t 34.125.26.221:8083/sample-app:$Docker_tag
                    """
                }
            }
        }

        
        stage('docker login & push'){
            steps{
                script{
                    sh """
                       docker login -u admin -p $docker_pws 34.125.26.221:8083
                       docker push 34.125.26.221:8083/sample-app:$Docker_tag
                    """
                    addBadge(icon: 'save.gif', text: 'docker repo', link: 'http://34.125.26.221:8081/#browse/browse:docker-hosted:v2%2Fsample-app')
                    currentBuild.description = "sample-app:$Docker_tag"
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