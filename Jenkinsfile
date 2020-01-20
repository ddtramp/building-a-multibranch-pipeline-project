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
                sh 'npm install'
                sh 'npm run build'
            }
        }
        stage('Making image') {
            steps {
                sh 'docker login -uddtrampdocker -pabs122825618'
                sh 'cd /var/jenkins_home/workspace/${JOB_NAME} && docker build -t ddtrampdocker/test:${VERSION} . && docker push ddtrampdocker/test:${VERSION}'
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

    
    post {
        success {
            emailext (
                subject: "'${env.JOB_NAME} [${env.BUILD_NUMBER}]' 更新正常",
                body: """
                详情：
                SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'
                状态：${env.JOB_NAME} jenkins 更新运行正常
                URL ：${env.BUILD_URL}
                项目名称 ：${env.JOB_NAME}
                项目更新进度：${env.BUILD_NUMBER}
                """,
                to: "wangxichao001@hotmail.com",
                recipientProviders: [[$class: 'DevelopersRecipientProvider']]
                )
                }
        failure {
            emailext (
                subject: "'${env.JOB_NAME} [${env.BUILD_NUMBER}]' 更新失败",
                body: """
                详情：
                FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'
                状态：${env.JOB_NAME} jenkins 运行失败
                URL ：${env.BUILD_URL}
                项目名称 ：${env.JOB_NAME}
                项目更新进度：${env.BUILD_NUMBER}
                """,
                to: "wangxichao001@hotmail.com",
                recipientProviders: [[$class: 'DevelopersRecipientProvider']]
                )
            }
    }

}