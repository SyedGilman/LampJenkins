pipeline {
    agent any

    environment {
        // Key ID from your Jenkins credentials
        SSH_KEY_ID    = 'target-server-ssh-key'
        SERVER_USER   = 'root'             
        SERVER_IP     = '172.30.2.2'       
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Transfer Deployment Script') {
            steps {
                echo "Copying deployment script using native scp..."
                // withCredentials is built-in and bypasses the buggy sshagent plugin
                withCredentials([sshUserPrivateKey(credentialsId: env.SSH_KEY_ID, keyFileVariable: 'KEY_FILE')]) {
                    sh """
                        chmod 600 ${KEY_FILE}
                        scp -i ${KEY_FILE} -o StrictHostKeyChecking=no deploy_lamp.sh ${SERVER_USER}@${SERVER_IP}:/tmp/deploy_lamp.sh
                    """
                }
            }
        }

        stage('Execute Deployment') {
            steps {
                echo "Executing script on target node..."
                withCredentials([sshUserPrivateKey(credentialsId: env.SSH_KEY_ID, keyFileVariable: 'KEY_FILE')]) {
                    sh """
                        chmod 600 ${KEY_FILE}
                        ssh -i ${KEY_FILE} -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} '
                            chmod +x /tmp/deploy_lamp.sh && \
                            /tmp/deploy_lamp.sh && \
                            rm /tmp/deploy_lamp.sh
                        '
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment finished successfully!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}
