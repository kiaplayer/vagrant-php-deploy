#!/bin/bash

node="$1"
if [ "$node" = "" ];
then
    echo "Usage: $0 node"
    exit 1
fi

if !(command -v chef-solo &> /dev/null);
then
    curl -LO https://www.getchef.com/chef/install.sh
    bash ./install.sh -v 11.16.0
    rm install.sh
fi

chef-solo -c solo.rb -j "nodes/${node}.json"
