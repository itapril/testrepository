FROM apache/apisix:3.11.0-redhat

RUN yum update -y \
	&& yum install -y openjdk-21-jdk \
	&& yum clean all
