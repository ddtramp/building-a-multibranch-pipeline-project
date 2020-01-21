def getHost(){
    def remote = [:]
    remote.name = "test-ui"
    remote.host = "172.17.0.3"
    remote.user = "root"
    remote.password = "root"
    remote.port = 22
    remote.allowAnyHosts = true
    if (env.VERSION == 'dev') {
        remote.host = "172.17.0.3"
        remote.user = "root"
        remote.password = "root"
    }
    return remote
}

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
        stage('Deploy Images'){
            steps {
                script {
                    server = getHost()
                        sshCommand remote: server, command: """
cat >docker-compose-test-ui.yml<<EOF
#VERSION:${env.VERSION}
version: '3.4'
services:

    edgepro-ui:
        image: ddtrampdocker/test:${env.VERSION}
        restart: always
        ports:
            - 80:80
        environment:
            version: ${env.VERSION}
            lalala: http://192.168.199.220:5188

EOF
                        """
                }
                script {
                    server = getHost()
                    sshCommand remote: server, command: """
			            docker-compose -f docker-compose-test-ui.yml pull && docker-compose -f docker-compose-test-ui.yml up -d
                    """
                }
            }
        }
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