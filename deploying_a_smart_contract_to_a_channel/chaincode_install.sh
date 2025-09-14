#!/bin/bash

TEST_NETWORK_DIR=$(echo $PWD | sed 's|\(/test-network\).*|\1|')
FABRIC_SAMPLES_DIR=$(echo $PWD | sed 's|\(/fabric-samples\).*|\1|')
EXPORT_RELATIVE_PATH="test-network/hlf-tutorials/export"
EXPORT_DIR="$FABRIC_SAMPLES_DIR/$EXPORT_RELATIVE_PATH"

cd $TEST_NETWORK_DIR

source $EXPORT_DIR/common_export.sh

peer_lifecycle_chaincode_install ()
{
	local exp="$1"
	
	source $EXPORT_DIR/$exp
	
	if peer lifecycle chaincode queryinstalled | grep 'Package ID'
	then
		echo "[WARNING]: $(date): Chaincode is already installed for $exp. No need to install it again."
	else
		if peer lifecycle chaincode install basic.tar.gz
		then
			echo "$(date): SUCCESSFUL installation of chaincode with $exp"
		else
			echo "[ERROR]: $(date): FAILED installation of chaincode witth $exp"
			exit 1
		fi
	fi
}

export_list=("org1_var_export.sh" "org2_var_export.sh")

for exp in "${export_list[@]}"
do	
	peer_lifecycle_chaincode_install "$exp"
done

exit
