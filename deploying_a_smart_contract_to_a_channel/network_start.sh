#!/bin/bash

TEST_NETWORK_DIR=$(echo $PWD | sed 's|\(/test-network\).*|\1|')

cd $TEST_NETWORK_DIR

if ./network.sh up
then
	echo "$(date): SUCCESSFUL ./network.sh up"
else
	echo "[ERROR]: $(date) FAILED /network.sh up"
	exit 1
fi

exit
