FROM bitnami/apisix:3.12.0

RUN sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get -y install openjdk-21-jdk
