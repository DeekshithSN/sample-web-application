pipeline {
    agent any

    stages {
        stage('clone'){
            steps {
                script {
                    echo "this is clone stage"

                }
            }
        }

        stage('build'){
            agent { label 'jenkins-java' }
            steps {
                script {
                        echo "this is build stage"
                }
            }
        }

        stage('deploy'){
            steps {
                script {
                        echo "this is build stage"
                }
            }
        }

    }
}
