#!/bin/bash

FABRIC_SAMPLES_DIR=$(echo $PWD | sed 's|\(/fabric-samples\).*|\1|')
CHAINCODE_GO_RELATIVE_PATH="asset-transfer-basic/chaincode-go"
CHAINCODE_GO_DIR="$FABRIC_SAMPLES_DIR/$CHAINCODE_GO_RELATIVE_PATH"
TEST_NETWORK_DIR=$(echo $PWD | sed 's|\(/test-network\).*|\1|')

EXPORT_RELATIVE_PATH="test-network/hlf-tutorials/export"
EXPORT_DIR="$FABRIC_SAMPLES_DIR/$EXPORT_RELATIVE_PATH"

cd $CHAINCODE_GO_DIR

# Install chaincode dependencies
GO111MODULE=on go mod vendor
ret=$?

if [ "$ret" -eq 0 ]; then
	echo "$(date): SUCCESSFULL dependencies installation"
else
	echo "[ERROR]: $(date): FAILED dependencies installation"
	exit 1
fi

cd $TEST_NETWORK_DIR
source $EXPORT_DIR/common_export.sh

if ! peer version; then
	echo "[ERROR]: $(date): FAILED command call: peer version"
	exit 1
fi

# Create chaincode package
if peer lifecycle chaincode package basic.tar.gz --path ../asset-transfer-basic/chaincode-go/ --lang golang --label basic_1.0
then
	echo "$(date): SUCCESSFULL Creating chaincode package basic.tar.gz"
else
	echo "[ERROR]: $(date): FAILED Creating chaincode package basic.tar.gz"
	exit 1
fi

exit
