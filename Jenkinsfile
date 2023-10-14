pipeline {
    agent any
    environment {
        REPOSITORY_URL = 'https://github.com/idrisskhaled/spring-boot-hello-world'
        DOCKER_HUB_REPO = 'idrisskhaled96/hello-world'  // Changed variable name
        IMAGE_TAG = 'latest'  // Corrected variable name
    }

    stages {
        stage('Clone repository') {
            steps {
                script {
                    if (fileExists('spring-boot-hello-world')) {
                        echo 'Repository already cloned, skipping step !'
                    } else {
                        sh "git clone ${env.REPOSITORY_URL}"  // Corrected shell command
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dir('spring-boot-hello-world') {
                        // Build the Docker image
                        sh "docker build -t ${env.DOCKER_HUB_REPO}:${env.IMAGE_TAG} ."
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub (you need Docker Hub credentials)
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                        withDockerRegistry([url: 'https://index.docker.io/v1/']) {
                            sh "docker logout"
                            sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                            sh "docker push ${env.DOCKER_HUB_REPO}:${env.IMAGE_TAG}"
                        }
                    }
                }
            }
        }
    }
}
