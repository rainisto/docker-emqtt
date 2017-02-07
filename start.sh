#!/bin/bash
NODE=$(dig +short $NODE_IP)
sed -i 's/127.0.0.1/'"$NODE"'/g' /emqttd/etc/emq.conf
/emqttd/bin/emqttd start
sleep 5
if [ -z ${MASTER+x} ]; then
echo '$MASTER' is not set.
else
CLUSTER=$(dig +short $MASTER)
/emqttd/bin/emqttd_ctl cluster join emqttd@$CLUSTER
fi
sleep 10 && tail -f --retry /emqttd/log/*
