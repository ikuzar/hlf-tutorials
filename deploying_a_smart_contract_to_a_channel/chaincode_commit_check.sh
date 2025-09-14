#!/bin/bash

TEST_NETWORK_DIR=$(echo $PWD | sed 's|\(/test-network\).*|\1|')
FABRIC_SAMPLES_DIR=$(echo $PWD | sed 's|\(/fabric-samples\).*|\1|')
EXPORT_RELATIVE_PATH="test-network/hlf-tutorials/export"
EXPORT_DIR="$FABRIC_SAMPLES_DIR/$EXPORT_RELATIVE_PATH"

cd $TEST_NETWORK_DIR

source $EXPORT_DIR/common_export.sh
source $EXPORT_DIR/org1_var_export.sh

if peer lifecycle chaincode querycommitted --channelID mychannel --name basic --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"
then
	echo "$(date): SUCCESSFUL commit check"
else
	echo "[ERROR]: $(date): FAILED commit check"
	exit 1
fi

exit
