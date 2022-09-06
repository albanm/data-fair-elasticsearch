FROM elasticsearch:8.4.1
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch ingest-attachment
