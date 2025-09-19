# hlf-tutorials
A collection of **bash scripts** to simplify and speed up the deployment of chaincode in **Hyperledger Fabric** described in the **Tutorials** section of the offcial website. This allows you to quickly re-run the deployment steps again.

## Features

- semi-automates common chaincode deployment steps described in the **Tutorials** section: https://hyperledger-fabric.readthedocs.io/en/latest/tutorials.html
- Reduces repetitive commands
- Based on official Hyperledger Fabric tutorial examples
- Made for beginners eager to learn about permissioned blockchains.
  
## Prerequisites

You must read and perform the steps described in **Getting Started - install** section: https://hyperledger-fabric.readthedocs.io/en/latest/getting_started.html
Here is the installation choice for this project:
- Linux
- Git
- cURL
- Go
- Docker
- Docker Compose
- JQ

## Getting Started

1. **Working environment**  

   The following configurations work and are used as part of this tutorial. Other configurations may work but I did not test it.
   - Linux: Debian 12.11
   - Git: 2.39.5
   - cURL: 7.88.1
   - Go: go1.19.8
   - Docker: 20.10.24+dfsg1
   - Docker Compose: 1.29.2
   - JQ: jq-1.6

At this stage, I suppose you already installed **Fabric** and **Fabric samples**. You can find the turorial installation here: https://hyperledger-fabric.readthedocs.io/en/release-2.5/install.html
   
2. **Create the working directory**  

   To create the working directory, we need your linux user name and your github ID. If your user name is **toto** and your github ID is **1234567**, then the working directory will be:
   /home/**toto**/go/src/github.com/**1234567**/fabric-samples/test-network.
   ```bash
   mkdir -p /home/toto/go/src/github.com/1234567/fabric-samples/test-network
   
IN PROGRESS...
