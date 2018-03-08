#!/bin/sh

set -e

sed -i  "s/LOGENTRIESTOKEN/$TOKEN/g" /etc/td-agent/logentries-tokens.conf
sed -i  "s/CLUSTERNAME/$CLUSTER_NAME/g" /etc/td-agent/logentries-tokens.conf

exec /usr/sbin/td-agent
