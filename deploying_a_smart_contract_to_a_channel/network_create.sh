#!/bin/bash

TEST_NETWORK_DIR=$(echo $PWD | sed 's|\(/test-network\).*|\1|')

cd $TEST_NETWORK_DIR

if ./network.sh up createChannel
then
	echo "$(date): SUCCESSFUL ./network.sh up createChannel"
else
	echo "[ERROR]: $(date) FAILED /network.sh up createChannel"
	exit 1
fi

exit
