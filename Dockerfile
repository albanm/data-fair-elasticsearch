FROM docker.elastic.co/elasticsearch/elasticsearch-oss:7.10.1
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch ingest-attachment
