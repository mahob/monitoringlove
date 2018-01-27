FROM centos:latest

ARG grafanaversion=5.0.0-11408pre1

RUN yum update -y && \
    yum install -y wget \
                   libfontconfig \
                   unzip \
                   # Required by the wait-for-psostgres.sh script
                   postgresql

# Install grafana
RUN wget https://s3-us-west-2.amazonaws.com/grafana-releases/master/grafana-${grafanaversion}.linux-x64.tar.gz && \
    tar -zxvf grafana-${grafanaversion}.linux-x64.tar.gz && \
    mv ./grafana-${grafanaversion} /grafana

# Add the diagram-panel plugin
RUN wget https://grafana.com/api/plugins/jdbranham-diagram-panel/versions/1.4.4/download -O diagram-panel-1.4.4.zip && \
    mkdir -p /grafana/plugins && \
    unzip diagram-panel-1.4.4.zip -d /grafana/plugins

# Provision datasources
RUN mkdir -p /grafana/conf/provisioning/datasources/
ADD ./grafana/conf/provisioning/datasources/* /grafana/conf/provisioning/datasources/

# Provision some dashboards (see http://docs.grafana.org/administration/provisioning/ for details)
# RUN mkdir -p /grafana/conf/provisioning/dashboards && \
#     mkdir -p /grafana/custom/dashboards
# ADD ./grafana/conf/provisioning/dashboards/* /grafana/conf/provisioning/dashboards
# ADD ./grafana/dashboards/* /grafana/dashboards/

RUN echo "==> content of /grafana/conf" && \
    find /grafana/conf -type f -exec cat {} \;

ADD ./grafana/conf/custom.ini /grafana/conf/custom.ini

# Wait for postgres
RUN mkdir -p /scripts/
COPY ./grafana/scripts/wait-for-postgres.sh /scripts/wait-for-postgres.sh
RUN chmod +x /scripts/wait-for-postgres.sh

WORKDIR /grafana

EXPOSE 3000