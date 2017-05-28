#!groovy

//def nodes = ['ubuntu14', 'ubuntu16', 'centos6', 'centos7']
def nodes = ['ubuntu14']
def builds = [:]

for (x in nodes) {
    def mynode = x

    // Create a map to pass in to the 'parallel' step so we can fire all the builds at once
    builds[mynode] = {
        node(mynode) {
            stage('Test') {
                sh 'brew test-bot --tap=kaust-rc/apps --junit'
                junit 'brew-test-bot.xml'
            }
        }
        post {
            success {
                slackSend channel: '#devops', color: 'good', message: '${env.JOB_NAME} (${env.BUILD_NUMBER}) was successfully built. Link to build: ${env.BUILD_URL}.'
            }
            failure {
                slackSend channel: '#devops', color: 'bad', message: '${env.JOB_NAME} (${env.BUILD_NUMBER}) failed; please look into it now! Link to build: ${env.BUILD_URL}.'
            }
            unstable {
                slackSend channel: '#devops', color: 'warning', message: '${env.JOB_NAME} (${env.BUILD_NUMBER}) is unstable; someone should check ASAP. Link to build: ${env.BUILD_URL}.'
            }
        }
    }
}

parallel builds
