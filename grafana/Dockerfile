FROM centos:latest

ARG grafanaversion=6.1.4
ENV grafanaarchivename=grafana-${grafanaversion}.linux-amd64.tar.gz

RUN yum update -y && \
    yum install -y wget \
                   libfontconfig \
                   unzip

RUN mkdir /install
WORKDIR /install/

# Enable the EPEL yum repo
RUN wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    rpm -ivh epel-release-latest-7.noarch.rpm

# Enable the Postgresql yum repo
RUN wget https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-3.noarch.rpm && \
    rpm -i pgdg-centos95-9.5-3.noarch.rpm

# Required by the wait-for-psostgres.sh script
RUN yum install -y postgresql95 --enablerepo=pgdg95

# Install grafana
RUN wget https://dl.grafana.com/oss/release/${grafanaarchivename} && \
    tar -zxvf ${grafanaarchivename} && \
    mv ./grafana-${grafanaversion} /grafana

# Install plugins
RUN mkdir -p /grafana/plugins

# Add the diagram-panel plugin
RUN wget https://grafana.com/api/plugins/jdbranham-diagram-panel/versions/1.4.4/download -O diagram-panel-1.4.4.zip && \
    unzip diagram-panel-1.4.4.zip -d /grafana/plugins

# Add the D3 gauge panel
# --- NOT SSUPPORTED FOR GRAFANA VERSION >= 5.0.0 ---
# RUN wget https://grafana.com/api/plugins/briangann-gauge-panel/versions/0.0.4/download -O d3-gauge-panel-0.0.4.zip && \
#     unzip d3-gauge-panel-0.0.4.zip -d /grafana/plugins

# Clean up all downloads
RUN rm -rf /install

# Add custom configuration
ADD ./conf/custom.ini /grafana/conf/custom.ini

# Provision datasources & dashboards (see http://docs.grafana.org/administration/provisioning/ for details)
RUN find /grafana/conf/provisioning/ -type f -exec rm -r {} \;
ADD ./conf/provisioning/dashboards/* /grafana/conf/provisioning/dashboards/
ADD ./conf/provisioning/datasources/* /grafana/conf/provisioning/datasources/
RUN mkdir -p /grafana/dashboards/
ADD ./dashboards/* /grafana/dashboards/

# Wait for postgres
RUN mkdir -p /scripts/
ADD ./scripts/wait-for-postgres.sh /scripts/wait-for-postgres.sh
RUN chmod +x /scripts/wait-for-postgres.sh

WORKDIR /grafana

EXPOSE 3000