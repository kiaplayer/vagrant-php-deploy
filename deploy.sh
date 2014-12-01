#!/bin/bash

# "$host" =~ /^[^@]+@[^@]+$/

host="$1"
if [ "$host" = "" ];
then
    echo "Usage: $0 user@host ssh-params"
    exit 1
fi

node=${host#*@}

# The host key might change when we instantiate a new VM, so
# we remove (-R) the old host key from known_hosts
ssh-keygen -R "$node" 2> /dev/null

tar cj -C ../ . | ssh -o 'StrictHostKeyChecking no' $@ "
sudo rm -rf /tmp/.chef &&
mkdir /tmp/.chef &&
cd /tmp/.chef &&
tar xj &&
chmod -R 700 /tmp/.chef &&
cd /tmp/.chef/deploy &&
sudo bash ./provision.sh $node &&
cd /tmp &&
sudo rm -rf /tmp/.chef"
