pipelineJob('test-dsl-pipeline') {
  definition {
    cpsScm {
      scm {
        git {
          remote {
            url('https://github.com/DeekshithSN/sample-web-application.git')
          }
          branch('hbc/weekday')
        }
      }
      lightweight()
    }
  }
}