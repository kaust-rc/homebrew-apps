#!groovy

//def nodes = ['ubuntu14', 'ubuntu16', 'centos6', 'centos7']
def nodes = ['ubuntu14', 'ubuntu16', 'centos7']
def builds = [:]

for (x in nodes) {
    def mynode = x

    // Create a map to pass in to the 'parallel' step so we can fire all the builds at once
    builds[mynode] = {
        node(mynode) {
            try {
                brew_home = "/home/jenkins/.linuxbrew"
                brew_bin = "${brew_home}/bin"
                kaust_tap = "${brew_home}/Library/Taps/kaust-rc/homebrew-apps"
                safe_path = "${brew_bin}:/usr/bin:/bin:/usr/sbin:/sbin"

                buildStatus = "PREPARING"

                stage('Prepare') {
                    timeout(time: 1, unit: 'HOURS') {
                        withEnv(["PATH=${safe_path}"]) {
                            sh "brew tap kaust-rc/apps"
                        }
                    }
                    sh "chmod 644 ${kaust_tap}/*.rb"
                }

                stage('Test') {
                    buildStatus = "TESTING"
                    timeout(time: 4, unit: 'HOURS') {
                        withEnv(["PATH=${safe_path}", 'HOMEBREW_DEVELOPER=1']) {
                            def formulae = sh script: "${kaust_tap}/list.formulae", returnStdout: true

                            println "Formulae to test: ${formulae}"

                            sh "brew test-bot --tap=kaust-rc/apps --junit --skip-setup ${formulae}"
                        }
                        junit 'brew-test-bot.xml'
                    }
                }

                buildStatus = "SUCCESSFUL"
            }
            catch(e) {
                buildStatus = "FAILED"
                throw e
            }
            finally {
                notifyBuild(mynode, buildStatus)
            }
        }
    }
}

parallel builds

def notifyBuild(String nodeName, String buildStatus) {
    // Default values
    nodeName = nodeName == null? 'Unknown Node' : nodeName
    buildStatus = buildStatus == null? 'SUCCESSFUL' : buildStatus
    def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' on node ${nodeName}"
    def summary = "${subject} (${env.BUILD_URL})"

    // Override default values based on build status
    if (buildStatus == 'FAILED') {
        color = '#FF0000'
    }
    else if (buildStatus == 'SUCCESSFUL') {
        color = '#00FF00'
    }
    else {
        // All other states means yellow/warning
        color = '#FFFF00'
    }

    // Send notifications
    slackSend (channel: '#devops', color: color, message: summary)
}
