FROM docker.elastic.co/elasticsearch/elasticsearch-oss:7.0.0
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch ingest-attachment
