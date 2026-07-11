def getDockerTag(){
    def tag = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    return tag
}

pipeline {
    agent { label 'linux' }

    environment {
        Docker_tag = getDockerTag()
        account_id = "941277531445" // Replace with your actual AWS account ID
        region = "ap-south-1" // Replace with your desired AWS region
        cluster_name = "jenkins-k8s" // Replace with your EKS cluster name
    }

    stages {
        stage('Validation & Checks') {
            parallel {
                stage('Commit Message Validation') {
                    steps {
                        script {
                            // Extract the latest commit message and save it to a temp file
                            def commitMsg = sh(script: 'git log -1 --pretty=%B', returnStdout: true).trim()
                            writeFile file: 'commit_msg.txt', text: commitMsg
                            echo "Validating commit message..."
                            
                            // Execute the verification script (assumed to be in your repo at scripts/check_commit.sh)
                            // If the script exits with status 1, the pipeline will fail here.
                            sh "chmod +x scripts/check_commit.sh"
                            // Catch errors from the validation script to mark the stage UNSTABLE instead of FAILURE
                            catchError(buildResult: 'UNSTABLE', stageResult: 'UNSTABLE') {
                                sh "./scripts/check_commit.sh commit_msg.txt"
                            }
                        }
                    }
                }
                stage('Check Dependencies') {
                    steps {
                        script {
                            echo "Verifying external service availability..."
                            sh "chmod +x scripts/check_dependencies.sh"
                            sh "./scripts/check_dependencies.sh"
                        }
                    }
                }
            }
        }
        stage('Static code analysis') {
            steps {
                script {
                    // Securely inject the credentials you created
                    withSonarQubeEnv(credentialsId: 'sonarqube-token') {
                        sh "mvn sonar:sonar"
                    }
                    timeout(time: 1, unit: 'HOURS') {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                }
            }
        }

        stage('Build & Test') {
            steps {
                script {
                    echo "Building the application..."
                    sh "mvn clean install"
                }
            }
        }

        stage('docker build') {
            steps {
                script {
                    echo "Building Docker image..."
                    sh "docker build -t myapp:${Docker_tag} ."
                }
            }
        }

        stage('Authentication of ECR and push the image') {
            steps {
                script {
                    echo "Authenticating to ECR..."
                    sh "aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${account_id}.dkr.ecr.${region}.amazonaws.com"
                    echo "Pushing Docker image to ECR..."
                    sh "docker tag myapp:${Docker_tag} ${account_id}.dkr.ecr.${region}.amazonaws.com/myapp:${Docker_tag}"
                    sh "docker push ${account_id}.dkr.ecr.${region}.amazonaws.com/myapp:${Docker_tag}"
                }
            }
        }

        stage('prepare manifest files and check connection with k8s cluster') {
          agent {
                docker {
                    image 'bitnami/kubectl:latest'
                    args '--entrypoint=""'
                    reuseNode true                // Ensures it runs on the same 'linux' workspace node
                }
            }
            steps { 
                script {
                    echo "Deploying to Kubernetes..."
                    sh "ls -l"
                    sh "sed -i 's|image_name|${account_id}.dkr.ecr.${region}.amazonaws.com/myapp:${Docker_tag}|g' deployment.yaml"
                    // Check connection to Kubernetes cluster
                    echo "Checking connection to Kubernetes cluster..."
                    sh "aws eks update-kubeconfig --region ${region} --name ${cluster_name}"
                    sh "kubectl get po"
                }
            }
        }


    }

  post {
        always {
            echo 'Cleaning up...'
            cleanWs()
        }
    }
}