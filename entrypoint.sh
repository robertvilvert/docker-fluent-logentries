#!/bin/sh

set -e

sed -i  "s/LOGENTRIESTOKEN/$TOKEN/g" /etc/td-agent/logentries-tokens.conf
echo $CA_CERT >> /etc/td-agent/secret_ca_file

exec /usr/sbin/td-agent
