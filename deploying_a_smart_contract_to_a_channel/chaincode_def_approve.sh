#!/bin/bash

TEST_NETWORK_DIR=$(echo $PWD | sed 's|\(/test-network\).*|\1|')
FABRIC_SAMPLES_DIR=$(echo $PWD | sed 's|\(/fabric-samples\).*|\1|')
EXPORT_RELATIVE_PATH="test-network/hlf-tutorials/export"
EXPORT_DIR="$FABRIC_SAMPLES_DIR/$EXPORT_RELATIVE_PATH"

cd $TEST_NETWORK_DIR

source $EXPORT_DIR/common_export.sh

peer_lifecycle_chaincode_approveformyorg ()
{
	local exp="$1"
	
	source $EXPORT_DIR/$exp
	
	PACKAGE_ID=$(peer lifecycle chaincode queryinstalled | grep Package | awk -F 'Package ID: |, Label' '{print $2}')
	ret=$?
	
	if [ "$ret" -ne 0 ]
	then
		echo "[ERROR]: $(date): FAILED to extract package ID for $exp"
		exit 1
	else
		# Approve the chaincode definition
		export CC_PACKAGE_ID=$PACKAGE_ID
		if peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID mychannel --name basic --version 1.0 --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"
		then
			echo "$(date): SUCCESSFUL chaincode approval for $exp"
		else
			echo "[ERROR]: $(date): FAILED chaincode approval for $exp"
			exit 1
		fi
	fi	
}

export_list=("org1_var_export.sh" "org2_var_export.sh")

for exp in "${export_list[@]}"
do	
	peer_lifecycle_chaincode_approveformyorg "$exp"
done

exit
