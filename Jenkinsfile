pipeline {
    agent any
    
    
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
                    dir('/var/lib/jenkins/workspace/challenge/challenge-04/') {
                    sh 'pwd'
                    sh 'terraform init'
                    sh 'terraform validate'
                    //sh 'terraform destroy -auto-approve'
                    sh 'terraform plan'
                    sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
        
        stage('Ansible Deployment') {
            steps {
                script {
                   sleep '200'
                    ansiblePlaybook becomeUser: 'ec2-user', credentialsId: 'amazonlinux', disableHostKeyChecking: true, installation: 'ansible', inventory: '/var/lib/jenkins/workspace/challenge/challenge-04/inventory.yaml', playbook: '/var/lib/jenkins/workspace/challenge/challenge-04/linux_playbook.yml', vaultTmpPath: ''
                    ansiblePlaybook become: true, credentialsId: 'ubuntuuser', disableHostKeyChecking: true, installation: 'ansible', inventory: '/var/lib/jenkins/workspace/challenge/challenge-04/inventory.yaml', playbook: '/var/lib/jenkins/workspace/challenge/challenge-04/ubuntu-playbook.yml', vaultTmpPath: ''
                }
            }
        }
    }
}
