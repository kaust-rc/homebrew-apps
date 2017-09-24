#!groovy

def nodes = ['biolinux:8', 'ubuntu:xenial', 'centos:6']
def containers = [:]

for (x in nodes) {
    def mynode = x

    // Create a map to pass in to the 'parallel' step so we can fire all the builds at once
    containers[mynode] = {
        node('docker') {
            timestamps {
                try {
                    brew_home = "/home/jenkins/.linuxbrew"
                    brew_bin = "${brew_home}/bin"
                    kaust_tap = "${brew_home}/Library/Taps/kaust-rc/homebrew-apps"
                    safe_path = "${brew_bin}:/usr/bin:/bin:/usr/sbin:/sbin"

                    buildStatus = "CREATING CONTAINER"

                    docker.withRegistry('http://10.254.154.110', 'docker-registry-credentials') {
                        stage("${mynode}: Update repo") {
                            checkout scm
                        }

                        docker.image("${mynode}").inside {
                            stage("${mynode}: Prepare") {
                                buildStatus = "PREPARING"
                                timeout(time: 1, unit: 'HOURS') {
                                    withEnv(["PATH=${safe_path}"]) {
                                        sh "brew update || brew update"
                                        sh "brew tap kaust-rc/apps"
                                    }
                                }
                                sh "chmod 644 ${kaust_tap}/*.rb"
                            }

                            stage("${mynode}: Test") {
                                buildStatus = "TESTING"

                                def formulae = sh script: "${kaust_tap}/list.formulae", returnStdout: true

                                println "Formulae to test: ${formulae}"

                                def formulaeList = formulae.split(" ")

                                for (f in formulaeList) {
                                    def formula = f

                                    timeout(time: 1, unit: 'HOURS') {
                                        withEnv(["PATH=${safe_path}", 'HOMEBREW_DEVELOPER=1']) {
                                            sh "brew install ${formula}"
                                            sh "brew audit ${formula}"
                                            sh "brew test ${formula} --verbose"
                                        }
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
}

parallel containers

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
