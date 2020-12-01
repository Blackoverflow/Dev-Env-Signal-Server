FROM ubuntu:20.04
LABEL maintainer="aaron@nanu-c.org"

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update
RUN apt-get install wget -y

# --> Install java 1.8 <--
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get -y upgrade
RUN apt-get -y update
RUN apt-get install openjdk-11-jdk openjdk-11-jre -y
RUN echo "JAVA_HOME=\"/usr/lib/jvm/java-1.11.0-openjdk-amd64\"" >>  /etc/environment
RUN ["/bin/bash", "-c", "source /etc/environment"]
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64" >>  ~/.bashrc
RUN echo "export PATH=\$JAVA_HOME/bin:\$PATH" >>  ~/.bashrc
RUN ["/bin/bash", "-c", "source ~/.bashrc"]
RUN update-ca-certificates -f
RUN apt-get install --reinstall ca-certificates-java

# --> Install maven 3.6.3 <--
RUN apt-get install maven -y
RUN cd /usr/local && wget https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
RUN cd /usr/local && tar xzf apache-maven-3.6.3-bin.tar.gz \ 
    && ln -s apache-maven-3.6.3 apache-maven
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64" >> /etc/profile.d/apache-maven.sh
RUN echo "export M2_HOME=/usr/local/apache-maven" >> /etc/profile.d/apache-maven.sh
RUN echo "export MAVEN_HOME=/usr/local/apache-maven" >> /etc/profile.d/apache-maven.sh
RUN echo "export PATH=\${M2_HOME}/bin:\${PATH}" >> /etc/profile.d/apache-maven.sh
RUN source /etc/profile.d/apache-maven.sh && mvn -version
RUN java -version

# COPY ./ssl /ssl

# --> Install Signal Server <--
COPY . /Signal-Server
RUN source /etc/profile.d/apache-maven.sh && cd /Signal-Server && mvn -e install -DskipTests

# --> Run server <--
EXPOSE 8080
EXPOSE 8081

CMD ["/bin/bash", "-c", "java -jar /Signal-Server/service/target/TextSecureServer-3.21.jar server /Signal-Server/service/config/config.yml"]