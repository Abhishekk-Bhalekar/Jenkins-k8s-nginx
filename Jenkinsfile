pipeline {
    agent any
    stages {
        stage('Checkout main branch') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'origin/main']], userRemoteConfigs: [[url: 'https://github.com/Abhishekk-Bhalekar/Jenkins-k8s-nginx.git']]])
            }
        }
        stage('Build Docker Image') {
            steps {
          sh "docker build -t abhishek5963/jenkins_k8s_nginx:${BUILD_NUMBER} ."
          sh "docker images"
          sh "sleep 10"
            }
        }
        stage('Test Docker Image') {
      steps {
          sh "docker run -d -p 80:80 --name nginx abhishek5963/jenkins_k8s_nginx:${BUILD_NUMBER}"
          sh "sleep 10"
          sh "docker rm -f nginx"
          sh "echo testing complete"
        }
      }
      stage('Push Docker Image To Repo') {
      steps {
          sh "docker login -u abhishek5963 -p Gheidtss@5963 "
          sh "docker push abhishek5963/jenkins_k8s_nginx:${BUILD_NUMBER}"
          sh "echo =============Successfully pushed docker image============"
          sh "docker logout"
        }
      }
      stage('modify manifest tag') {
      steps {
        sh "sed -i -e 's%abhishek5963/jenkins_k8s_nginx:.*%abhishek5963/jenkins_k8s_nginx:${BUILD_NUMBER}%g' mainfests files/deployment.yml"
        sh 'cat mainfests files/deployment.yml'
      }
    }
     stage('Deploy to K8s') {
      steps{
        script {
          sh "cat mainfests files/deployment.yml"
          sh "minikube delete --all"
          sh "./setup.sh"
          sh "kubectl cluster-info"
          sh "sleep 10"
          sh "kubectl create -f mainfests files/deployment.yml"
          sh "kubectl create -f mainfests files/service-file.yml"
          sh "kubectl create -f mainfests files/configmaps.yml"
          sh "kubectl get pods"
          sh "sleep 60"
          sh "minikube service nginx-service"
        }
      }
    }

    }
}
