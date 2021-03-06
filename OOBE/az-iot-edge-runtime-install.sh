#!/bin/bash

# Copyright (c) 2019 Intel Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#      http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Purpose: Install's IoT Edge Runtime SDK and dependencies
# usage:
#   $sudo ./az-iot-edge-runtime-install.sh
#
# Author: Pradeep, Sakhamoori
# Date  : 10/27/2019

# Install dependencies
apt-get update
apt-get install ca-certificates curl apt-transport-https lsb-release gnupg

# Install IoT Edge Runtime - Ubuntu16.04
ret=$(curl https://packages.microsoft.com/config/ubuntu/16.04/multiarch/prod.list > ./microsoft-prod.list)

# Download and install the Microsoft signing key
ret=$(curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null)

# Generated list 
ret=$(cp ./microsoft-prod.list /etc/apt/sources.list.d/)

AZ_REPO=$(lsb_release -cs)
ret=$(echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list)

apt-get update
apt-get install azure-cli

# Install container runtime and dependencies 
apt-get update
apt-get install moby-engine
apt-get install moby-cli
apt-get update
apt-get install iotedge


