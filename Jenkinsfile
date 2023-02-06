   def getDockerTag(){
        def tag = sh script: 'git rev-parse --short HEAD', returnStdout: true
        return tag
        }

pipeline{
    agent any
    environment{
        Docker_tag = getDockerTag()
        docker_login = credentials('public-docker-auth')
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
                    sh """
                    pwd 
                    ls -la
                    cp -r ../backend-app@2/target .
                    docker build . -t deekshithsn/webapp:$Docker_tag
                    """
                    currentBuild.description = "deekshithsn/webapp:$Docker_tag"
                }
            }
        }

        stage('docker upload'){
            steps{
                script{
                    sh """
                        docker login -u $docker_login_USR -p $docker_login_PSW
                        docker push deekshithsn/webapp:$Docker_tag
                    """
                    addBadge(icon: 'info.gif', text: 'docker registry', link: 'https://hub.docker.com/repository/docker/deekshithsn/webapp/general')
                }
            }
        }

        stage('approval from managers'){
            input {
                message "do you want to procced for deployment?"
                ok "Procced?"
                submitter "alice,bob"
                parameters {
                    string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
                }
            }
             steps{
                script{
                        sh "echo Approved!!!!"
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

        stage('authenticate & deploy'){
            steps{
                script{
                    sh"""
                        export KUBECONFIG=/opt/config
                        kubectl get po 
                        kubectl apply -f deployment.yaml
                    """
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