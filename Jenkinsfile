#!groovy

//def nodes = ['ubuntu14', 'ubuntu16', 'centos6', 'centos7']
def nodes = ['ubuntu14']
def builds = [:]

for (x in nodes) {
    def mynode = x

    // Create a map to pass in to the 'parallel' step so we can fire all the builds at once
    builds[mynode] = {
        node(mynode) {
            try {
                stage('Prepare') {
                    timeout(time: 10, unit: 'MINUTES') {
                        withEnv(["PATH=/home/jenkins/.linuxbrew/bin:/usr/bin:/bin:/usr/sbin:/sbin", 'HOMEBREW_DEVELOPER=1']) {
                            sh "brew tap kaust-rc/apps"
                        }
                    }
                    sh "chmod 644 /home/jenkins/.linuxbrew/Library/Taps/kaust-rc/homebrew-apps/*.rb"
                }

                stage('Test') {
                    timeout(time: 1, unit: 'HOURS') {
                        withEnv(["PATH=/home/jenkins/.linuxbrew/bin:/usr/bin:/bin:/usr/sbin:/sbin", 'HOMEBREW_DEVELOPER=1']) {
                            sh "brew test-bot --tap=kaust-rc/apps --junit weather"
                        }
                        junit 'brew-test-bot.xml'
                    }
                }
            }
            catch(e) {
                currentBuild.result = "FAILED"
                throw e
            }
            finally {
                notifyBuild(currentBuild.result)
            }
        }
    }
}

parallel builds

def notifyBuild(String buildStatus = 'SUCCESSFUL') {
    // Default values
    def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
    def summary = "${subject} (${env.BUILD_URL})"

    // Override default values based on build status
    if (buildStatus == 'UNSTABLE') {
        color = 'warning'
    }
    else if (buildStatus == 'SUCCESSFUL') {
        color = 'good'
    }
    else {
        color = 'bad'
    }

    // Send notifications
    slackSend (channel: '#devops', color: color, message: summary)
}
