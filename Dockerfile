FROM python:2
MAINTAINER Oleksandr Kosse <okosse@mirantis.com>

RUN  apt-get update -qq &&  \
apt-get install -q -y \
    python-dev \
    libvirt-dev && \
pip install pdbpp && \
apt-get clean  && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt/

RUN pip install xunit2testrail

ENV TESTRAIL_PLAN_NAME="[Sprint-5]System"
ENV SHORT_TEST_GROUP="mcp-11-newton-ovs"
ENV TESTRAIL_URL="https://mirantis.testrail.com"
ENV TESTRAIL_USER='okosse@mirantis.com
ENV TESTRAIL_PASSWORD='password'
ENV TESTRAIL_PROJECT='Mirantis Cloud Platform'
ENV TESTRAIL_MILESTONE='MCP1.1'
ENV TESTRAIL_SUITE='Tempest 15.0.0'


COPY entrypoint.sh /opt/

ENTRYPOINT ["/opt/entrypoint.sh"]