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

        stage('Run Docker Container') {
            steps {
                echo 'Running Docker container...'
                sh 'docker stop devops-task-container'
                sh 'docker rm devops-task-container'
                sh 'docker run -d --name devops-task-container -p 8080:8080 $IMAGE_NAME:$TAG'
            }
        }

/*        stage('Setup Kubeconfig') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                sh '''
                    kubectl config current-context
                    '''
        }
      }
    }*/

        stage('Deploy to Local Kubernetes') {
            steps {
                echo 'Deploying to Kubernetes...'
                sh 'kubectl apply -f helloapp-deployment.yaml'
                sh 'kubectl apply -f helloapp-service.yaml'
            }
        }
    }
}
