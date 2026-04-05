# Copyright Broadcom, Inc. All Rights Reserved.
# SPDX-License-Identifier: APACHE-2.0

FROM tomcat:9.0-jdk8
RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*
