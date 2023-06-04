pipeline {
    agent any

    stages {
        stage('clone'){
            steps {
                script {
                    cleanWs()
                    echo "this is clone stage"
                    sh """
                    git clone https://github.com/DeekshithSN/cheatsheet.git
                    git clone https://github.com/DeekshithSN/Unix_and_shell.git
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat cheatsheet/installtion_guide_ubuntu.md
                    cat Unix_and_shell/unix/more/logfilr
                    cat Unix_and_shell/unix/more/logfilr
                    cat Unix_and_shell/unix/more/logfilr
                    cat Unix_and_shell/unix/more/logfilr
                    cat Unix_and_shell/unix/more/logfilr
                    cat Unix_and_shell/unix/more/logfilr
                    cat Unix_and_shell/unix/more/logfilr
                    cat Unix_and_shell/unix/more/logfilr
                    cat Unix_and_shell/unix/more/logfilr
                    cat Unix_and_shell/unix/more/logfilr
                    cat Unix_and_shell/unix/more/logfilr
                    cat Unix_and_shell/unix/more/logfilr
                    cat Unix_and_shell/unix/more/logfilr
                    cat Unix_and_shell/unix/more/logfilr
                    cat Unix_and_shell/unix/more/logfilr
                    
                    i=1
                    while [ "$i" -le 101 ]; do
                        cat cheatsheet/installtion_guide_ubuntu.md
                        cat Unix_and_shell/unix/more/logfilr
                        i=$(( i + 1 ))
                    done 
                    """

                }
            }
        }

        stage('build'){
            agent {
                docker {
                   image 'python:3.7-buster'
                }
            
            }
            steps {
                script {
                        sh " python --version"
                }
            }
        }

        stage('deploy'){
             agent {
                docker {
                   image 'python:3.9-buster'
                }
            
            }
            steps {
                script {
                        sh " python --version"
                }
            }
        }

    }
}
