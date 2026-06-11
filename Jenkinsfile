pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                // Pulls your code from GitHub to the local Jenkins workspace
                checkout scm
            }
        }

        stage('Install LAMP Stack') {
            steps {
                echo "Installing LAMP stack locally..."
                
                // Running standard shell commands directly on the host machine
                sh '''
                    sudo apt-get update -y
                    sudo apt-get install apache2 mysql-server php libapache2-mod-php php-mysql -y
                '''
            }
        }

        stage('Start Services') {
            steps {
                echo "Starting and enabling Apache & MySQL..."
                sh '''
                    sudo systemctl start apache2
                    sudo systemctl enable apache2
                    sudo systemctl start mysql
                    sudo systemctl enable mysql
                '''
            }
        }
    }

    post {
        success {
            echo 'LAMP Server successfully installed locally!'
        }
    }
}
