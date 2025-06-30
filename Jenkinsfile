pipeline {
    agent any

    environment {
        IMAGE_NAME = "helloapp"
        TAG = "latest"
    }

    stages {

        stage('Build Environment') {
            steps {
                echo 'Running build.sh...'
                sh 'chmod +x build.sh'
                sh './build.sh'
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo 'Running tests...'
                sh 'chmod +x test.sh'
                sh 'bash test.sh'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t $IMAGE_NAME:$TAG .'
            }
        }

//Assuming a docker container is running with this name but we either don't get to this stage(so we don't stop the previous working one) or we get to this stage and make a container for it.
//the only exception would be running it for the first time but a docker run most likely happens during manual testing unless there is a different cluster for developing and jenkins 
        stage('Run Docker Container') {
            steps {
                echo 'Running Docker container...'
                sh 'docker stop devops-task-container'
                sh 'docker rm devops-task-container'
                sh 'docker run -d --name devops-task-container -p 8080:8080 $IMAGE_NAME:$TAG'
            }
        }

        stage('Deploy to Local Kubernetes') {
            steps {
                echo 'Deploying to Kubernetes...'
                    sh 'kubectl --kubeconfig=/var/lib/jenkins/kubeconfig/config apply -f helloapp-deployment.yaml'
                    sh 'kubectl --kubeconfig=/var/lib/jenkins/kubeconfig/config apply -f helloapp-service.yaml'
            }
        }
    }
}
