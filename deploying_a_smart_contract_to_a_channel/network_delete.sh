#!/bin/bash

TEST_NETWORK_DIR=$(echo $PWD | sed 's|\(/test-network\).*|\1|')

cd $TEST_NETWORK_DIR

network_down ()
{
	if ./network.sh down
	then
		echo "$(date): SUCCESSFUL ./network.sh down"
	else
		echo "[ERROR]: $(date) FAILED ./network.sh down"
		exit 1
	fi
}

echo "WARNING !!! This command will delete channel, cryptographic objects and potentially other objets"

read -p "Are you sure you want to delete those objects ? [y/N]" answer
case "$answer" in
	[yY]|[yY][eE][sS])
		network_down
		;;
	*)
		echo "Operation cancelled."
		;;
esac

exit
