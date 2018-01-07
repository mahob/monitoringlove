FROM phusion/baseimage:latest

ARG grafanaversion

RUN apt-get update -y

RUN apt-get install -y wget \
                       libfontconfig \
                       unzip \
                       # Required by the wait-for-psostgres.sh script
                       postgresql-client-9.5

RUN wget https://s3-us-west-2.amazonaws.com/grafana-releases/master/grafana-${grafanaversion}.linux-x64.tar.gz && \
    tar -zxvf grafana-${grafanaversion}.linux-x64.tar.gz && \
    mv ./grafana-${grafanaversion} /grafana

# Add the diagram-panel plugin
RUN wget https://grafana.com/api/plugins/jdbranham-diagram-panel/versions/1.4.4/download -O diagram-panel-1.4.4.zip && \
    mkdir -p /grafana/plugins && \
    unzip diagram-panel-1.4.4.zip -d /grafana/plugins

# Provision some dashboards (see http://docs.grafana.org/administration/provisioning/ for details)
RUN mkdir -p /grafana/provisioning/dashboards
ADD ./grafana/dashboard-provider.yml /grafana/provisioning/dashboards
ADD ./grafana/provisioned-dashboards/ /grafana/

COPY /grafana/custom.ini /grafana/conf/custom.ini

# Wait for postgres
RUN mkdir -p /scripts/
COPY ./grafana/scripts/wait-for-postgres.sh /scripts/wait-for-postgres.sh
RUN chmod +x /scripts/wait-for-postgres.sh

WORKDIR /grafana

EXPOSE 3000