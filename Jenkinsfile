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

        stage('authenticate and prepare k8s manifest files'){
            steps{
                script{
                    configFileProvider([configFile(fileId: 'kube-dev-config', variable: 'KUBECONFIG')]) {
                        sh '''
                            kubectl get po
                            final_tag=$(echo $Docker_tag | tr -d ' ')
                            sed -i "s|TAG|$final_tag|" deployment.yaml
                            cat deployment.yaml
                        '''
                    }
                }
            }
        }

        stage('approval stage'){
            steps{
                script{
                    timeout(5){
                        mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "${currentBuild.result} CI: Project name -> ${env.JOB_NAME}", to: "deekshithsn@gmail.com";
                        input( message: "Deploy ${params.project_name}?", ok: 'Deploy')
                    }
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

    post {
        always{
            cleanWs()
        }
    }
}