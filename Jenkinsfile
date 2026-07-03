pipeline {
    agent any

    parameters {
        string(name: 'PROJECT_NAME', defaultValue: 'sample-web-application', description: 'Project name')
    }

    stages{
     stage('Fetch Remote GitHub Branches') {
          steps {
              script {
                  // Securely inject the credentials you created
                  withCredentials([usernamePassword(credentialsId: 'my-git-api-token', passwordVariable: 'GIT_TOKEN', usernameVariable: 'GIT_USER')]) {
                      
                      // Define your target repo details
                      def orgOrUser = "DeekshithSN"
                      
                      // Make the API call using curl
                      def response = sh(
                          script: "curl -s -u ${GIT_USER}:${GIT_TOKEN} https://api.github.com/repos/${orgOrUser}/${PROJECT_NAME}/branches",
                          returnStdout: true
                      ).trim()
                      
                      // Parse the JSON response to extract branch names
                      def json = readJSON text: response
                      def branchList = json.collect { it.name }
                      
                      echo "Available branches in ${repoName}: ${branchList}"
                  }
              }
          }
    }
  }
}