pipeline {
    agent any
    environment {
        BUILD_COMPLETE = false
    }
    stages {
        stage('Build') {
            failFast true
            parallel {
                stage('Building') {
                    steps {
                        
                        sh "mvn clean install  |  tee output.log"

                        sh '! grep "WARNING" output.log'

                        script {
                            BUILD_COMPLETE = true
                        }
                    }
                }
                stage('Monitoring the logs') {
                    steps {
                        script {
                            while (BUILD_COMPLETE != true) {
                                sh '! grep "WARNING" output.log'
                            }
                        }
                    }
                }
            }
        }
    }
}
