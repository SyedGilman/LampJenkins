pipeline {
    agent any

    environment {
        // Define your target server credentials ID configured in Jenkins
        SSH_CRED_ID   = 'target-server-ssh-key'
        SERVER_USER   = 'root'
        SERVER_IP     = '172.30.2.2' // Replace with your actual target server IP
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Pulls the latest code from your GitHub repo
                checkout scm
            }
        }

        stage('Transfer Deployment Script') {
            steps {
                echo "Copying deployment script to the target server..."
                // Uses SSH Agent plugin to securely copy the script
                sshagent([env.SSH_CRED_ID]) {
                    sh "scp -o StrictHostKeyChecking=no deploy_lamp.sh ${SERVER_USER}@${SERVER_IP}:/tmp/deploy_lamp.sh"
                }
            }
        }

        stage('Execute Deployment') {
            steps {
                echo "Executing LAMP installation script on target server..."
                sshagent([env.SSH_CRED_ID]) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} '
                            chmod +x /tmp/deploy_lamp.sh && \
                            sudo /tmp/deploy_lamp.sh && \
                            rm /tmp/deploy_lamp.sh
                        '
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'LAMP Server successfully deployed and configured!'
        }
        failure {
            echo 'Deployment failed. Check the Jenkins build logs for details.'
        }
    }
}
