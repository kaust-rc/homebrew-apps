#!groovy

def nodes = ['ubuntu:xenial', 'centos:6', 'centos:7']
for (x in nodes) {
    def mynode = x

    node('docker') {
        timestamps {
            try {
                buildStatus = "CREATING CONTAINER"

                docker.withRegistry('http://10.254.154.110', 'docker-registry-credentials') {
                    // Let's mount Jenkins HOME so we can speedup tests
                    docker.image("${mynode}").inside("-v /home/jenkins:/home/jenkins:rw,z") {
                        stage("${mynode}: Run tests") {
                            buildStatus = "PREPARING"
                            checkout scm
                            sh script: "scripts/tap.kaust.apps.sh"

                            buildStatus = "TESTING"
                            def formulae = sh script: "scripts/list.formulae", returnStdout: true
                            println "Formulae to test: ${formulae}"

                            // We CANNOT run tests in parallel because Linuxbrew complains
                            // about multiple processes trying to work on it
                            def formulaeList = formulae.split(" ")
                            for (f in formulaeList) {
                                def formula = f

                                timeout(time: 1, unit: 'HOURS') {
                                    sh script: "scripts/test.formula.sh ${formula}"
                                }
                            }
                        }

                        buildStatus = "SUCCESSFUL"
                    }
                }
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
    slackSend (channel: '#linuxbrew', color: color, message: summary)
}
