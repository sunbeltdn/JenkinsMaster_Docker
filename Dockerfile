FROM ubuntu:latest

MAINTAINER dongna <sunbeltdn@163.com>


#install jdk8 and maven
RUN apt-get update  && apt-get install -qqy curl openjdk-8-jdk && apt-get install -q -y maven

RUN java -version

RUN mvn -version


#install system net tools
RUN apt-get install net-tools

#install git
RUN apt-get install -q -y git


#config JENKINS_HOME
RUN useradd jenkins --shell /bin/bash
RUN mkdir /home/jenkins
RUN chown jenkins:jenkins /home/jenkins

USER jenkins

#download latest jenkins war file
RUN curl -sf -o /home/jenkins/jenkins.war -L http://mirrors.jenkins-ci.org/war-stable/latest/jenkins.war

#download plugins
RUN mkdir /home/jenkins/plugins

#pipeline plugins
RUN curl -sf -o /home/jenkins/plugins/pipeline-build-step.hpi -L http://mirrors.jenkins-ci.org/plugins/pipeline-build-step/latest/pipeline-build-step.hpi
RUN curl -sf -o /home/jenkins/plugins/pipeline-input-step.hpi -L http://mirrors.jenkins-ci.org/plugins/pipeline-input-step/latest/pipeline-input-step.hpi
RUN curl -sf -o /home/jenkins/plugins/pipeline-rest-api.hpi -L http://mirrors.jenkins-ci.org/plugins/pipeline-rest-api/latest/pipeline-rest-api.hpi
RUN curl -sf -o /home/jenkins/plugins/pipeline-stage-view.hpi -L http://mirrors.jenkins-ci.org/plugins/pipeline-stage-view/latest/pipeline-stage-view.hpi
RUN curl -sf -o /home/jenkins/plugins/pipeline-stage-step.hpi -L http://mirrors.jenkins-ci.org/plugins/pipeline-stage-step/latest/pipeline-stage-step.hpi

RUN curl -sf -o /home/jenkins/plugins/workflow-aggregator.hpi -L http://mirrors.jenkins-ci.org/plugins/workflow-aggregator/latest/workflow-aggregator.hpi
RUN curl -sf -o /home/jenkins/plugins/workflow-api.hpi -L http://mirrors.jenkins-ci.org/plugins/workflow-api/latest/workflow-api.hpi
RUN curl -sf -o /home/jenkins/plugins/workflow-basic-steps.hpi -L http://mirrors.jenkins-ci.org/plugins/workflow-basic-steps/latest/workflow-basic-steps.hpi
RUN curl -sf -o /home/jenkins/plugins/workflow-cps.hpi -L http://mirrors.jenkins-ci.org/plugins/workflow-cps/latest/workflow-cps.hpi
RUN curl -sf -o /home/jenkins/plugins/workflow-cps-global-lib.hpi -L http://mirrors.jenkins-ci.org/plugins/workflow-cps-global-lib/latest/workflow-cps-global-lib.hpi
RUN curl -sf -o /home/jenkins/plugins/workflow-cps.hpi -L http://mirrors.jenkins-ci.org/plugins/workflow-cps/latest/workflow-cps.hpi
RUN curl -sf -o /home/jenkins/plugins/workflow-durable-task-step.hpi -L http://mirrors.jenkins-ci.org/plugins/workflow-durable-task-step/latest/workflow-durable-task-step.hpi
RUN curl -sf -o /home/jenkins/plugins/workflow-job.hpi -L http://mirrors.jenkins-ci.org/plugins/workflow-job/latest/workflow-job.hpi
RUN curl -sf -o /home/jenkins/plugins/workflow-multibranch.hpi -L http://mirrors.jenkins-ci.org/plugins/workflow-multibranch/latest/workflow-multibranch.hpi
RUN curl -sf -o /home/jenkins/plugins/workflow-scm-step.hpi -L http://mirrors.jenkins-ci.org/plugins/workflow-scm-step/latest/workflow-scm-step.hpi
RUN curl -sf -o /home/jenkins/plugins/workflow-step-api.hpi -L http://mirrors.jenkins-ci.org/plugins/workflow-step-api/latest/workflow-step-api.hpi
RUN curl -sf -o /home/jenkins/plugins/workflow-support.hpi -L http://mirrors.jenkins-ci.org/plugins/workflow-support/latest/workflow-support.hpi

#create folder by github organization
RUN curl -sf -o /home/jenkins/plugins/github-organization-folder.hpi -L http://mirrors.jenkins-ci.org/plugins/pipeline-build-step/latest/github-organization-folder.hpi

#ssh by master and slaves
RUN curl -sf -o /home/jenkins/plugins/ssh-slaves.hpi -L http://mirrors.jenkins-ci.org/plugins/pipeline-build-step/latest/ssh-slaves.hpi

#git related plugins
RUN curl -sf -o /home/jenkins/plugins/git-client.hpi -L http://mirrors.jenkins-ci.org/plugins/pgit-client/latest/git-client.hpi
RUN curl -sf -o /home/jenkins/plugins/github-oauth.hpi -L http://mirrors.jenkins-ci.org/plugins/github-oauth/latest/github-oauth.hpi
RUN curl -sf -o /home/jenkins/plugins/github-api.hpi -L http://mirrors.jenkins-ci.org/plugins/github-api/latest/github-api.hpi
RUN curl -sf -o /home/jenkins/plugins/github-branch-source.hpi -L http://mirrors.jenkins-ci.org/plugins/github-branch-source/latest/github-branch-source.hpi
RUN curl -sf -o /home/jenkins/plugins/github.hpi -L http://mirrors.jenkins-ci.org/plugins/github/latest/github.hpi
RUN curl -sf -o /home/jenkins/plugins/git-server.hpi -L http://mirrors.jenkins-ci.org/plugins/git-server/latest/git-server.hpi
RUN curl -sf -o /home/jenkins/plugins/git.hpi -L http://mirrors.jenkins-ci.org/plugins/git/latest/git.hpi

#role based user mgmt
RUN curl -sf -o /home/jenkins/plugins/role-strategy.hpi -L http://mirrors.jenkins-ci.org/plugins/role-strategy/latest/role-strategy.hpi


#generate keystore for SSL configuration
RUN keytool -genkey -keyalg RSA -alias selfsigned -keystore /home/jenkins/keystore.jks -storepass password123 -dname "cn=localhost"

USER root

ADD startJenkins.sh /usr/local/bin/startJenkins

RUN chmod 755 /usr/local/bin/startJenkins

ENTRYPOINT ["/usr/local/bin/startJenkins"]

EXPOSE 8082


