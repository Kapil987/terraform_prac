# Stage One for build
FROM amazonlinux AS build
ENV PATH $PATH:/opt/jdk11/bin
ENV JAVA_HOME /opt/jdk11
ENV M2_HOME /opt/maven

RUN yum install wget tar git gzip -y && \
# JDK setup
    wget https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz && \
    tar -xzf openjdk-11+28_linux-x64_bin.tar.gz && \
    mv jdk-11 /opt/jdk11 && \
    export PATH && export JAVA_HOME

# Maven
RUN wget https://archive.apache.org/dist/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz && \
    tar -xzf apache-maven-3.8.6-bin.tar.gz && \
    mv apache-maven-3.8.6 /opt/maven/

# Web App
COPY ./id_rsa /root/.ssh/id_rsa
RUN chmod -R 700 /root/.ssh && \
    chown -R root:root /root/.ssh && \
    chmod 600 /root/.ssh/id_rsa && \
# ssh-keysacn is used to avoid prompt to add host in known_hosts file
    ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts && \
    git clone git@bitbucket.org:kapilhsr/java-login-app.git /opt/app
WORKDIR /opt/app

# Maven build in workdir /opt/app as 'mvn package' need src folder
RUN /opt/maven/bin/mvn package


## Stage Second for build
FROM amazonlinux
ENV PATH $PATH:/opt/jdk11/bin
ENV JAVA_HOME /opt/jdk11
RUN yum install wget tar gzip -y

# JDK setup
RUN wget https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz && \
    tar -xzf openjdk-11+28_linux-x64_bin.tar.gz && \
    mv jdk-11 /opt/jdk11

# Tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.82/bin/apache-tomcat-8.5.82.tar.gz && \
    tar -xzf apache-tomcat-8.5.82.tar.gz && \
    mv apache-tomcat-8.5.82 /opt/tomcat
COPY --from=build /opt/app/target/dptweb-1.0.war /opt/tomcat/webapps/
CMD ["/opt/tomcat/bin/catalina.sh","run"]

### Notes
## Even if folder is not created 'mv' will create a folder and move the contents
## this can be used tar -xzf apache-maven-3.8.6-bin.tar.gz -C /opt/maven/ , but this copies complete folder not the content
## Make sure you add public key in the repository
## to view our deployed app in the web-browser we will need to use the folder name of our .war or .jar file such as http://Your_IP:8080/dptweb-1.0/


