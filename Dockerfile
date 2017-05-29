FROM jboss/base-jdk:7
MAINTAINER Jose Manuel Moreno Gavira <josem.moreno.gavira@gmail.com>

USER	root

# locales
RUN		yum -y update
ENV		LANG en_US.utf8

# jboss eap 5.2 (jboss files)
ENV		JBOSS_SOA_HOME /opt/jboss/jboss-soa-p-5
COPY	files/jboss-soa-p-5.tar.gz-part-* /opt/jboss/
RUN		cat /opt/jboss/jboss-soa-p-5.tar.gz-part-* > /opt/jboss/jboss-soa-p-5.tar.gz
RUN		tar -zxvf /opt/jboss/jboss-soa-p-5.tar.gz -C /opt/jboss/
RUN		rm -rf /opt/jboss/jboss-soa-p-5.2.tar.gz*
RUN		ln -s /opt/jboss/jboss-soa* ${JBOSS_SOA_HOME}

# jboss snapshot (jboss server configuration)
COPY	files/myconf.tar.gz-part-* ${JBOSS_SOA_HOME}/jboss-as/server/
RUN		cat ${JBOSS_SOA_HOME}/jboss-as/server/myconf.tar.gz-part-* > ${JBOSS_SOA_HOME}/jboss-as/server/myconf.tar.gz
RUN		tar -zxvf ${JBOSS_SOA_HOME}/jboss-as/server/myconf.tar.gz -C ${JBOSS_SOA_HOME}/jboss-as/server/
RUN		rm -rf ${JBOSS_SOA_HOME}/jboss-as/server/myconf.tar.gz*

# shell scripts
COPY	files/jboss-soa	/usr/local/bin/
RUN		chmod +x /usr/local/bin/jboss-soa

# launch JBoss using default profile
#ENTRYPOINT	["/usr/local/bin/jboss-soa", "default"]
