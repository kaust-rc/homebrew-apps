#!groovy

//def nodes = ['xenial']
def nodes = ['xenial', 'trusty', 'centos7', 'centos6']
def builds = [:]


for (x in nodes) {
    def mynode = x

    // Create a map to pass in to the 'parallel' step so we can fire all the builds at once
    builds[mynode] = {
        node(mynode) {
            stage('Test') {
                sh 'brew test-bot --tap=kaust-rc/apps'
                junit 'brew-test-bot.xml'
            }
        }
        post {
            success {
                slackSend color: 'good', message: '${env.JOB_NAME} (${env.BUILD_NUMBER}) was successfully built. Link to build: ${env.BUILD_URL}.'
            }
            failure {
                slackSend color: 'bad', message: '${env.JOB_NAME} (${env.BUILD_NUMBER}) failed; please look into it now! Link to build: ${env.BUILD_URL}.'
            }
            unstable {
                slackSend color: 'warning', message: '${env.JOB_NAME} (${env.BUILD_NUMBER}) is unstable; someone should check ASAP. Link to build: ${env.BUILD_URL}.'
            }
        }
    }
}

parallel builds
