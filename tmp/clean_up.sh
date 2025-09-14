#!/bin/bash

docker stop logspout

docker rm logspout

./network.sh down

exit
