pipeline {
    agent any
    // agent {
    //     docker {
    //         image 'node:6-alpine'
    //         args '-p 3000:3000'
    //     }
    // }
    environment { 
        CI = 'true'
    }
    stages {
        stage('Build') {
            steps {
                sh 'npm install',
                sh 'npm run build'
            }
        }
        stage('Making image') {
            steps {
                sh 'docker login -uddtrampdocker -pabs122825618',
                sh 'cd /var/jenkins_home/workspace/${JOB_NAME} docker build -t ddtrampdocker/test:${VERSION} . && docker push ddtrampdocker/test:${VERSION}'
            }
        }
    //     stage('Deliver') { 
    //         steps {
    //             sh './jenkins/scripts/deliver.sh' 
    //             input message: 'Finished using the web site? (Click "Proceed" to continue)' 
    //             sh './jenkins/scripts/kill.sh' 
    //         }
    //     }
    }
}