#!/bin/sh
export JENKINS_HOME=/home/jenkins
export JENKINS_HTTPPORT=-1
export JENKINS_HTTPSPORT=8082
java -Xms256M -Xmx2048M -jar jenkins.war --httpPort=$JENKINS_HTTPPORT --httpsPort=$JENKINS_HTTPSPORT --httpsKeyStore=$JENKINS_HOME/keystore.jks --httpsKeyStorePassword=password123 > /home/jenkins/startJenkins.log 2>&1 &
