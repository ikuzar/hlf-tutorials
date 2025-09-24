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

At this stage, I suppose you already installed **Fabric** and **Fabric samples**. You can find the tutorial installation here: https://hyperledger-fabric.readthedocs.io/en/release-2.5/install.html
   
2. **Acess test-network directory**  

   I assume your user name is **toto** and your github ID is **1234567**
   
   ```bash
   cd /home/toto/go/src/github.com/1234567/fabric-samples/test-network
   
3. **clone the project**  

   Now you can clone the project into the **test-network** directory.
   ```bash 
   git clone https://github.com/ikuzar/hlf-tutorials.git

  The following steps correspond to **Tutorials > Deploying a smart contract to a channel** part of the tutorials. You can find it here: https://hyperledger-fabric.readthedocs.io/en/release-2.5/deploy_chaincode.html


4. **Access working directory**  

   The working directory is **deploying_a_smart_contract_to_a_channel**
   ```bash
   cd /home/toto/go/src/github.com/1234567/fabric-samples/test-network/hlf-tutorials/deploying_a_smart_contract_to_a_channel
   ```
   
5. **Create, start and monitor the test network**  

   The test network include several entities such as organizations, peers, orderer which are operational entities and channel that we can consider as a logical entity. If you already installed these entities and want to delete them before reinstalling, you need to delete the network.
   ```bash
   cd /home/toto/go/src/github.com/1234567/fabric-samples/test-network/hlf-tutorials/deploying_a_smart_contract_to_a_channel
   ./network_delete.sh
   ```

   If you start from scratch, you can create the network.
   ```bash
   ./network_create.sh
   ```

   Then start the test network.
   ```bash
   ./network_start.sh
   ```

   At this stage you can monitor the logs of the smart contract via the aggregated output from a set of Docker containers. Please open a new terminal and type the following commands:
   ```bash
   cd /home/toto/go/src/github.com/1234567/fabric-samples/test-network
   ./monitordocker.sh fabric_test
   ```

  6. **Package the chaincode**
     
   chaincode must be packaged before installing it on the peers.
   ```bash
   ./chaincode_package.sh
   ```

   If the following error occurs, you can probably bypass it by edit the go.mod file.   
   This is the error:
   ```bash
   go: errors parsing go.mod:
   /home/toto/go/src/github.com/1234567/fabric-samples/asset-transfer-basic/chaincode-go/go.mod:3: invalid go version '1.23.0': must match format 1.23
   ```
   
   Delete the last digit from go.mod (change go 1.23.0 to go 1.23)
   ```bash
   module github.com/hyperledger/fabric-samples/asset-transfer-basic/chaincode-go

   //go 1.23.0
   go 1.23
   ```

7. **Install the chaincode package**
   
The chaincode needs to be installed on every peer that will endorse a transaction. The script chaincode_install.sh installs the chaincode on both peer1 and peer2. You can monitor the installation process in the monitoring terminal (./monitordocker.sh fabric_test).   
**FYI**: _In a real situation, it's the rôle of the organization's administrator to install the chaincode on the peer._   
```bash
./chaincode_install.sh
```   
The chaincode installed on a peer cannot be executed until its definition has been approved and committed by the channel’s member organizations.   

8. **Approve a chaincode definition**

A number of organizations must approve the chaincode definition. In our case, org1 and org2 must approve it.   
**FYI**: _In a real situation, it's the rôle of each administrator of the organization concerned to run the program that approves the chaincode definition_.   

To check if there is already an approved chaincode definition, run the following command.
```bash
./chaincode_approval_check.sh
```

To run the chaincode definition approval, run the following command. You can follow the approval process log via the monitoring terminal.
```bash
./chaincode_def_approve.sh
```
You can check the result by running again this command:   
```bash
./chaincode_approval_check.sh
```











   
   
