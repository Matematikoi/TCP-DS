FROM mcr.microsoft.com/mssql/server:2017-CU30-ubuntu-18.04

# Create a config directory
RUN mkdir -p /usr/config
RUN mkdir -p /usr/config/tmp_data
WORKDIR /usr/config

# Bundle config source
COPY ./configure-db.sh /usr/config
COPY ./entrypoint.sh /usr/config
COPY ./setup.sql /usr/config
COPY ./create_tables.sql /usr/config
COPY ./tmp_data /usr/config/tmp_data
COPY ./upload-data.sql /usr/config/upload-data.sql
COPY ./create-index.sql /usr/config/create-index.sql

# Grant permissions for to our scripts to be executable
RUN chmod +x /usr/config/entrypoint.sh
RUN chmod +x /usr/config/configure-db.sh

ENTRYPOINT ["./entrypoint.sh"]

# Tail the setup logs to trap the process
CMD ["tail -f /dev/null"]

HEALTHCHECK --interval=15s CMD /opt/mssql-tools/bin/sqlcmd -U sa -P $SA_PASSWORD -Q "select 1" && grep -q "MSSQL CONFIG COMPLETE" ./config.log
