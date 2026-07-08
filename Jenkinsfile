pipeline {
    agent { label 'linux' }
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
    }

  post {
        always {
            echo 'Cleaning up...'
            cleanWs()
        }
    }
}