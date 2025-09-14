#!/bin/bash

TEST_NETWORK_DIR=$(echo $PWD | sed 's|\(/test-network\).*|\1|')
FABRIC_SAMPLES_DIR=$(echo $PWD | sed 's|\(/fabric-samples\).*|\1|')
EXPORT_RELATIVE_PATH="test-network/hlf-tutorials/export"
EXPORT_DIR="$FABRIC_SAMPLES_DIR/$EXPORT_RELATIVE_PATH"

cd $TEST_NETWORK_DIR

source $EXPORT_DIR/common_export.sh
source $EXPORT_DIR/org1_var_export.sh

if peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID mychannel --name basic --version 1.0 --sequence 1 --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt"
then
	echo "$(date): SUCCESSFUL chaincode definition commit"
else
	echo "[ERROR]: $(date): FAILED chaincode definition commit"
	exit 1
fi

#peer lifecycle chaincode querycommitted --channelID mychannel --name basic

exit
