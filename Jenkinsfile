pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = "chikkalavenkatasai"   // your Docker Hub username
        IMAGE_NAME = "dog-gallery"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/venkat-369/sample.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t $DOCKER_HUB_USER/$IMAGE_NAME:$IMAGE_TAG .
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub',   // Jenkins credentials ID
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $DOCKER_HUB_USER/$IMAGE_NAME:$IMAGE_TAG
                        docker logout
                    '''
                }
            }
        }

        stage('Deploy to Docker Swarm') {
            steps {
                sh '''
                    docker service update --image $DOCKER_HUB_USER/$IMAGE_NAME:$IMAGE_TAG dog-gallery || \
                    docker service create --name dog-gallery -p 8080:80 $DOCKER_HUB_USER/$IMAGE_NAME:$IMAGE_TAG
                '''
            }
        }
    }
}


    

