#!groovy

def nodes = ['biolinux:8', 'ubuntu:xenial', 'centos:6']
//def containers = [:]

for (x in nodes) {
    def mynode = x

    node('docker') {
        timestamps {
            try {
                // Set Linuxbre paths
                brew_home = "/home/jenkins/.linuxbrew"
                brew_bin = "${brew_home}/bin"
                kaust_tap = "${brew_home}/Library/Taps/kaust-rc/homebrew-apps"
                safe_path = "${brew_bin}:/usr/bin:/bin:/usr/sbin:/sbin"

                buildStatus = "CREATING CONTAINER"

                docker.withRegistry('http://10.254.154.110', 'docker-registry-credentials') {
                    stage("${mynode}: Update repo") {
                        checkout scm
                    }

                    // Let's mount Jenkins HOME so we can speedup tests
                    docker.image("${mynode}").inside("-v /home/jenkins:/home/jenkins:rw,z") {
                        stage("${mynode}: Prepare") {
                            buildStatus = "PREPARING"
                            timeout(time: 1, unit: 'HOURS') {
                                withEnv(["PATH=${safe_path}"]) {
                                    sh "brew tap kaust-rc/apps"
                                    sh "chmod 644 ${kaust_tap}/*.rb"
                                }
                            }
                        }

                        stage("${mynode}: Test") {
                            buildStatus = "TESTING"

                            def formulae = sh script: "${kaust_tap}/list.formulae", returnStdout: true
                            println "Formulae to test: ${formulae}"

                            // We CANNOT run tests in parallel because Linuxbrew complains
                            // about multiple process trying to work on it
                            def formulaeList = formulae.split(" ")
                            for (f in formulaeList) {
                                def formula = f

                                timeout(time: 1, unit: 'HOURS') {
                                    withEnv(["PATH=${safe_path}", 'HOMEBREW_DEVELOPER=1']) {
                                        sh "brew reinstall ${formula}"
                                        // sh "brew audit --strict ${formula}"
                                        sh "brew audit ${formula}"
                                        sh "brew test ${formula}"
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
