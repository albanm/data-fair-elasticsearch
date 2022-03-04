FROM elasticsearch:7.17.1
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch ingest-attachment
