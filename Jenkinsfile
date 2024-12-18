pipeline {
    agent any
      environment {
        AWS_ACCESS_KEY_ID = credentials('aws_credentials')  // ID from Jenkins credentials store
        AWS_SECRET_ACCESS_KEY = credentials('aws_credentials')  // ID from Jenkins credentials store
     }

    stages {
        

        stage('Checkout') {
            steps {
                deleteDir()
                sh 'echo cloning repo'
                sh 'git clone https://github.com/reshma2307/challenge-04.git' 
            }
        }
        
        stage('Terraform Apply') {
            steps {
                script {
                    dir('/var/lib/jenkins/workspace/ansible-tf/ansible-task/') {
                    sh 'pwd'
                    sh 'terraform init'
                    sh 'terraform validate'
                    sh 'terraform destroy -auto-approve'
                    //sh 'terraform plan'
                    sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
        
        stage('Ansible Deployment') {
            steps {
                script {
                   sleep '150'
                    ansiblePlaybook becomeUser: 'ec2-user', credentialsId: 'aws_credentials', disableHostKeyChecking: true, installation: 'ansible', inventory: '/var/lib/jenkins/workspace/ansible_jenkins_challenge/challenge-04/inventory.yaml', playbook: '/var/lib/jenkins/workspace/ansible_jenkins_challenge/challenge-04/linux_playbook.yml', vaultTmpPath: ''
                    ansiblePlaybook become: true, credentialsId: 'aws_credentials', disableHostKeyChecking: true, installation: 'ansible', inventory: '/var/lib/jenkins/workspace/ansible_jenkins_challenge/challenge-04/inventory.yaml', playbook: '/var/lib/jenkins/workspace/ansible_jenkins_challenge/challenge-04/ubuntu-playbook.yml', vaultTmpPath: ''
                }
            }
        }
    }
}
 
