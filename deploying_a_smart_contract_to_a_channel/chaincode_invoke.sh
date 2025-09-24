#!/bin/bash

TEST_NETWORK_DIR=$(echo $PWD | sed 's|\(/test-network\).*|\1|')
FABRIC_SAMPLES_DIR=$(echo $PWD | sed 's|\(/fabric-samples\).*|\1|')
EXPORT_RELATIVE_PATH="test-network/hlf-tutorials/export"
EXPORT_DIR="$FABRIC_SAMPLES_DIR/$EXPORT_RELATIVE_PATH"

cd $TEST_NETWORK_DIR

source $EXPORT_DIR/common_export.sh
source $EXPORT_DIR/org1_var_export.sh

# InitLedger
if peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n basic --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"InitLedger","Args":[]}'
then
	echo "$(date): SUCCESSFUL chaincode invocation"
else
	echo "[ERROR]: FAILED chaincode invocation"
	exit 1
fi

# Read the set of cars that were created by the chaincode
peer chaincode query -C mychannel -n basic -c '{"Args":["GetAllAssets"]}'
ret=$?
if [ $ret -eq 0 ]
then
	echo "$(date): SUCCESSFUL Assets Read"
else
	echo "[ERROR]: FAILED Assets Read"
	exit 1
fi

exit
