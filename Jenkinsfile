pipeline {
    agent any

    stages{
      stage("build"){
        steps{
          echo "Building the application..."
          sh "printenv"
          sh '''            
            echo "This is a multi-line shell command."
            echo "You can run multiple commands here."
            echo "The current build number is ${BUILD_NUMBER}."
          '''
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