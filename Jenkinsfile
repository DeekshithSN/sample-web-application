pipeline {
    agent any

    environment { 
        CC = 'clang'
        dockerpass = credentials('docker-hub-password')
        dockeruserpass = credentials('docker-user-pass')
    }

    parameters { 
        string(name: 'DEPLOY_TO', defaultValue: 'staging', description: '') 
        choice(name: 'CHOICES', choices: ['one', 'two', 'three'], description: '')
        }

    triggers { 
        upstream(upstreamProjects: 'job1,job2', threshold: hudson.model.Result.SUCCESS)
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '5')) 
        timestamps()
    }

    stages {
        stage('Parallel Stage') {
            parallel {
                stage('first stage'){

                    steps{
                        script{
                            sh "sleep 120"
                            sh "hostname"   
                            sh "docker login -u $dockeruserpass_USR -p $dockeruserpass_PSW"
                        }
                    }
                }

                stage('second stage'){

                    agent {
                        docker {
                            image 'java:openjdk-8u111-jdk-alpine'
                        }
                    }

                

                    environment { 
                            project = 'jenkins-demo'
                        }

                    steps{
                        script{
                            retry (3){
                                sh "sleep 120"
                                sh "java -version"
                                sh "printenv"
                            }
                        }
                    }
                }
            }
        }

        stage('third stage'){

            agent {
                dockerfile {
                     filename 'Dockerfile'
                }
            }

            steps{
                script{
                    sh "hostname"
                     sh "echo hello world"
                     sh "python -h"
                     sh "printenv"
                }
            }
        }
        stage('fourth stage'){
            when { 
                anyOf {
                environment name: 'DEPLOY_TO', value: 'production';
                environment name: 'GIT_BRANCH', value: 'master'
                } 
            }
            steps{
                script{
                    sh "echo hostname > test.txt" 
                    
                     
                }
            }
            post{
                success{
                    archiveArtifacts artifacts: 'test.txt', followSymlinks: false
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
