# Use the official Node.js 16 image as base image
FROM node:16.14.0-buster

# Upgrade npm to the latest version
RUN npm install -g npm@9.6.2

# Set the author of the Dockerfile
LABEL maintainer="YIN"
