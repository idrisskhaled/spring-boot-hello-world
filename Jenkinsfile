properties([pipelineTriggers([githubPush()])])

node {
    git credentialsId: 'github-creds',
        url: 'https://github.com/idrisskhaled/spring-boot-hello-world', branch: 'master'
}

pipeline {
    agent any
    environment {
        REPOSITORY_URL = 'https://github.com/idrisskhaled/spring-boot-hello-world'
        DOCKER_HUB_REPO = 'idrisskhaled96/hello-world'
        IMAGE_TAG = 'latest'
        PATH = "/opt/sonarqube/bin:${env.PATH}"
        SONAR_PROJECT_KEY = "spring-boot-hello-world"
    }

    stages {
        stage('Clone repository') {
            steps {
                script {
                    checkout([$class: 'GitSCM'])
                }
            }
        }
            
        stage('SonarQube Analysis') {
            steps {
                script {
                    // Run SonarQube analysis
                    withSonarQubeEnv('SonarQube') {
                        sh "mvn -f pom.xml sonar:sonar -Dsonar.exclusions=**/*.java"
                    }

                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                        // Build the Docker image
                        sh "docker build -t ${env.DOCKER_HUB_REPO}:${env.IMAGE_TAG} ."
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
                            sh 'echo $dockerHubPassword | docker login -u $dockerHubUser --password-stdin'
                            sh "docker push ${env.DOCKER_HUB_REPO}:${env.IMAGE_TAG}"
                        }
                    }
                }
            }
        }

         stage('Update user jenkins roles') {
            steps {
                script {
                    sh 'ansible-playbook -i localhost update-role.yml'
                }
            }
        }

         stage('Delete available resources') {
            steps {
                script {
                     kubeconfig(credentialsId: 'k8s', serverUrl: 'https://10.0.0.4:6443') {
                       sh 'kubectl delete -f deployment.yaml'

                    }
                }
            }
        }


        stage('Deploy to k8s cluster') {
            steps {
                script {
                    kubeconfig(credentialsId: 'k8s', serverUrl: 'https://10.0.0.4:6443') {
                       sh 'kubectl apply -f deployment.yaml'

                    }
                }
            }
        }
    }
    
}