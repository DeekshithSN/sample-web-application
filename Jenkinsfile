pipeline {
    agent any

    stages{
      stage("build"){
        steps{
          echo "Building the application..."
          sh "printenv"
        }
      }
      stage("test"){
        steps{
          echo "Running tests..."
        }
      }
      stage("deploy"){
        steps{
          echo "Deploying the application..."
        }
      }
    }
}