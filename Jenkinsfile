pipeline {
    agent any

    environment { 
        CC = 'clang'
        CXX = 'clang++'
        CFLAGS = '-Wall -Wextra'
        CXXFLAGS = '-Wall -Wextra -std=c++17'
    }

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
          sh '''
            # Use the exported environment variable CXXFLAGS in the shell
            echo "The current CXXFLAGS is $CXXFLAGS."
          '''
        }
      }
      stage("deploy"){
        steps{
          echo "Deploying the application..."
        }
      }
    }
}