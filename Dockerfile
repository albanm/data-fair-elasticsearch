FROM docker.elastic.co/elasticsearch/elasticsearch-oss:6.3.2
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch ingest-attachment
