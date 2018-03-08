FROM robertvilvert/fluentd-ubuntu:latest

MAINTAINER Robert Vilvert <robert.lvilvert@gmail.com>
USER root
WORKDIR /etc/td-agent/

# Copy configuration files
COPY ./conf/td-agent.conf /etc/td-agent/
COPY ./conf/kubernetes.conf /etc/td-agent/
COPY ./conf/logentries-tokens.conf /etc/td-agent/
#COPY ./conf/secret_ca_file /etc/td-agent/


# Copy plugins
COPY plugin /etc/td-agent/plugin/
COPY entrypoint.sh /etc/td-agent/entrypoint.sh

# Environment variables
ENV FLUENTD_OPT=""
ENV FLUENTD_CONF="fluent.conf"

# Run Fluentd
CMD ["/etc/td-agent/entrypoint.sh"]
