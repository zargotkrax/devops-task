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
                bash test.sh
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t $IMAGE_NAME:$TAG .'
            }
        }

        stage('Run Docker Container') {
            steps {
                echo 'Running Docker container...'
                sh 'docker run -d -p 8080:8080 $IMAGE_NAME:$TAG'
            }
        }

        stage('Deploy to Local Kubernetes') {
            steps {
                echo 'Deploying to Kubernetes...'
                sh 'kubectl apply -f k8s/helloapp-deployment.yaml'
                sh 'kubectl apply -f k8s/helloapp-service.yaml'
            }
        }
    }
}
