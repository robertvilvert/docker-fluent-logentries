#!/bin/sh

set -e

sed -i  "s/LOGENTRIESTOKEN/$TOKEN/g" /fluentd/etc/logentries-tokens.conf
sed -i  "s/CLUSTERNAME/$CLUSTER_NAME/g" /fluentd/etc/logentries-tokens.conf

exec fluentd -c /fluentd/etc/${FLUENTD_CONF} -p /fluentd/plugins ${FLUENTD_OPT}
