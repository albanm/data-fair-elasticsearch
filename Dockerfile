FROM elasticsearch:7.17.6
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch ingest-attachment
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch repository-s3

# Accept let's encrypt certificates for S3 compatible snapshot repositories
ADD import-letsencrypt-java.sh .
RUN chmod u+x import-letsencrypt-java.sh
RUN ./import-letsencrypt-java.sh